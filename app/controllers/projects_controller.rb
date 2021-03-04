class ProjectsController < ApplicationController
  # before_action :authenticate_user!, except: %i[index show]
  before_action :set_project, only: %i[show edit update destroy]

  def index
    @projects = Project.all
    # @projects = policy_scope(Project)
    @user = current_user
  end

  def show
    @number = 0
    @project_participants = Participant.where(project_id: @project.id)
    join_request_pending(@project)
  end

  def join_request_pending(project)
    @participant = Participant.where(user_id: current_user.id, project_id: project.id)
    @join_requests = @participant.map do |participation|
      participation.is_founder? ? JoinRequest.where(project_id: participation.project.id, request_pending: true) : nil
    end
  end

  def new
    @project = Project.new
    # authorize @project # pundit authorization
  end

  def create
    @project = Project.new(projects_params)
    @project.user = current_user
    # authorize @project # pundit authorization ANTES DE SALVAR
    if @project.save
      create_participant(@project)
    else
      render :new, notice: "The project could not be created. Something went wrong. Please try again."
    end
  end

  def create_participant(project)
    @participant = Participant.new(user_id: current_user.id, participant_id: nil, project_id: project[:id], is_founder: true, invited_at: DateTime.now, accepted_at: DateTime.now)
    if @participant.save
      redirect_to project_path(project.id), notice: "The new project was created and #{current_user.name} was saved as project participant."
    else
      redirect to_to new_project_path, notice: "The project was saved but #{current_user.name} failed to be saved as a project participant, please delete the project and try again."
    end
  end

  def edit
  end

  def update
    @project = Project.find(projects_params)
    @project.update = (projects_params)
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
      redirect_to project_path(id: @project.id), notice: "Sent request to join #{@project.name}. Expect a reply from the founder(s) shortly."
    else
      redirect_to project_path(id: @project.id), notice: "Error. Your request to join #{@project.name} could not be sent. Please try again."
    end
  end

  def join_request_authorize
    @join_request = JoinRequest.find(params[:join_request_id])
    @project = @join_request.project
    @join_request.request_pending = false
    @join_request.save
    @user = @join_request.user
    redirect_to project_participant_create_path(user_id: @user, project_id: @project)
  end

  def join_request_refuse
  end

  private

  def set_project
    @project = Project.find(params[:id])
    # authorize @project # pundit authorization
  end

  def projects_params
    params.require(:project).permit(:name, :description, :linkedin_url, :github_url, :trello_url)
  end
end
