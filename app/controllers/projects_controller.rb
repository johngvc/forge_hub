class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_project, only: %i[show edit update destroy]
  before_action :pundit_policy_authorized?, only: %i[join_request_do join_request_authorize]

  def index
    @projects = policy_scope(Project)
    @participating_projects = []
    @available_projects = []
    @suspended_projects_participating = []
    @ongoing_projects_participating = []

    @projects.each do |project|
      is_part_of_project = !Participant.where(project_id: project, user_id: current_user.id).first.nil?

      if is_part_of_project
        @participating_projects << project
        if !project.is_suspended?
          @ongoing_projects_participating << project
        elsif project.is_suspended?
          @suspended_projects_participating << project
        end
      elsif !is_part_of_project
        @available_projects << project
      end
    end
  end

  def show
    @number = 0
    @project_participants = Participant.where(project_id: @project.id)
    @participant = Participant.where(user_id: current_user.id, project_id: @project.id).first
    @is_not_participant = @participant.nil?
    @is_not_participant ? @is_participant = false : @is_participant = true
    participant_join_requests = JoinRequest.where(project_id: @project.id, user_id: current_user.id, request_pending: true)
    participant_join_requests.first.nil? ? @has_join_request = false : @has_join_request = true
    set_join_request_pending(@project, @participant, @is_participant)
  end

  def join_request_pending
    # Action para exibir view dos join_requests_pending separadamente
    @project = Project.find(params[:project_id])
    authorize @project # pundit authorization
    @number = 0
    @participant = Participant.where(user_id: current_user.id, project_id: @project.id).first
    @is_not_participant = @participant.nil?
    @is_not_participant ? @is_participant = false : @is_participant = true
    set_join_request_pending(@project, @participant, @is_participant)
  end

  def set_join_request_pending(project, participant, is_participant)
    if is_participant && participant.status == 'founder' || is_participant && participant.status == 'cofounder'
      @join_requests = JoinRequest.where(project_id: project.id, request_pending: true)
    else
      @join_requests = nil
    end
  end

  def new
    @project = Project.new
    authorize @project # pundit authorization
  end

  def create
    @project = Project.new(projects_params)
    @project.user = current_user
    authorize @project # pundit authorization ANTES DE SALVAR
    if @project.save
      create_participant(@project)
    else
      render :new, notice: "The project could not be created. Something went wrong. Please try again."
    end
  end

  def create_participant(project)
    @participant = Participant.new(user_id: current_user.id, project_id: project[:id], is_founder: true, invited_at: DateTime.now, accepted_at: DateTime.now, status: 'founder')
    if @participant.save
      @participant.invite_participant_id = @participant.id
      @participant.save
      redirect_to project_path(project.id), notice: "The new project was created and #{current_user.name} was saved as project participant."
    else
      render :new, notice: "The project was saved but #{current_user.name} failed to be saved as a project participant, please delete the project and try again."
    end
  end

  def edit
  end

  def update
    @project.update(projects_params)
    if @project.save
      redirect_to project_path(@project)
    else
      render :new, notice: "Something went wrong. Try again "
    end
  end

  def destroy
    @participant = Participant.where(user_id: current_user.id, project_id: @project.id).first
    if @participant.is_founder?
      @project.destroy
      redirect_to projects_path, notice: "Project deleted."
    else
      redirect_to project_path(@project), notice: "Projects can only be deleted by founders."
    end
  end

  def join_request_do
    @user = current_user
    @message = params[:request_message]
    @project = Project.find(params[:project_id])
    @join_request = JoinRequest.new(project_id: @project.id, user_id: @user.id, created_at: DateTime.now, content: @message)
    if @join_request.save
      pass_request_to_chat(@message, @user, @project)
      redirect_to project_path(id: @project.id), notice: "Sent request to join #{@project.name}. Expect a reply from the founder(s) shortly."
    else
      redirect_to project_path(id: @project.id), notice: "Error. Your request to join #{@project.name} could not be sent. Please try again."
    end
  end

  def pass_request_to_chat(message, sender, project)
    request_message = "#{sender.name} wants to join #{project.name}! Please review #{sender.name}'s request in the #{project.name} profile page. Message: #{message}"
    project_founders = Participant.where(project_id: project.id, status: 'founder')
    project_founders.each do |founder|
      message = ChatMessage.new(user_sender_id: sender.id, user_receiver_id: founder.user.id, sent_at: DateTime.now, content: request_message)
      message.save
    end
  end

  def join_request_authorize
    @join_request = JoinRequest.find(params[:join_request_id])
    @project = @join_request.project
    @join_request.request_pending = false
    @join_request.save
    @user = @join_request.user
    pass_authorize_to_chat(@project, @join_request)
    redirect_to project_participant_create_path(user_id: @user, project_id: @project), notice: "#{@join_request.user.name}`s application to #{@project.name} was accepted. The user was automatically notified of the fact."
  end

  def pass_authorize_to_chat(project, join_request)
    authorize_message = "Congratulations! Your application to #{project.name} was accepted! The founders of #{project.name} have authorized your request to join their project. Please reach ou to them to coordinate the next steps."
    user_receiver = join_request.user.id
    user_sender = Participant.where(project_id: project.id, status: 'founder').first
    message = ChatMessage.new(user_sender_id: user_sender.user.id, user_receiver_id: user_receiver, sent_at: DateTime.now, content: authorize_message)
    message.save
  end

  def join_request_refuse
    @join_request = JoinRequest.find(params[:join_request_id])
    @project = @join_request.project
    @join_request.request_pending = false
    @join_request.save
    redirect_to project_path(id: @project), notice: "#{@join_request.user.name}`s application to #{@project.name} was refused. The user was automatically notified of the fact."
    pass_refuse_to_chat(@project, @join_request)
  end

  def pass_refuse_to_chat(project, join_request)
    refuse_message = "Unfortunatelly, your application to #{project.name} was not accepted. Refusals are normal and expected in this field. Try applying to another project."
    user_receiver = join_request.user.id
    user_sender = Participant.where(project_id: project.id, status: 'founder').first
    message = ChatMessage.new(user_sender_id: user_sender.user.id, user_receiver_id: user_receiver, sent_at: DateTime.now, content: refuse_message)
    message.save
  end

  def reply_to_join_request
    respond_to do |format|
      format.html
      format.js
    end
    message = ChatMessage.new(user_sender_id: current_user.id, user_receiver_id: params[:user_receiver_id], sent_at: DateTime.now, content: params[:content])
    message.save
  end

  def pundit_policy_authorized?
    true
  end

  private

  def set_project
    @project = Project.find(params[:id])
    authorize @project # pundit authorization
  end

  def projects_params
    params.require(:project).permit(:id, :name, :description, :linkedin_url, :github_url, :trello_url, :photo, :is_suspended, :content)
  end
end
