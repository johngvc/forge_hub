class ParticipantsController < ApplicationController
  # before_action :authenticate_user!, except: %i[index]
  before_action :set_participant, only: %i[new create index]
  before_action :set_participant_edit, only: %i[edit]
  before_action :pundit_policy_scoped?
  before_action :pundit_policy_authorized?

  def index
    @participants = Participant.where(project_id: @project.id)
    @current_participant = Participant.where(project_id: @project.id, user_id: current_user.id).first
    num_founders = 0
    @participants.each do |participant| 
      if participant.status == 'founder'
        num_founders += 1  
      end
    end
    num_founders > 2 ? @more_than_one_founder = true : @more_than_one_founder = false
  end

  def new
    @participant = Participant.create(project_id: params[:project_id], user_id: params[:user_id], participant_id: @current_participant.id, invited_at: DateTime.now, status: 'invitee')
  end

  def create
    @invite_participant = Participant.where(project_id: params[:project_id], user_id: current_user.id).first
    @participant = Participant.create(project_id: params[:project_id], user_id: params[:user_id], invite_participant_id: @invite_participant.id, invited_at: DateTime.now, status: 'invitee')
    if @participant.save
      redirect_to project_participants_path(params[:project_id]), notice: "#{@participant.user.name} is now a project participant"
    else
      render :new
    end
  end

  def update_status
    @participant = Participant.find(params[:participant_id])
    @participant.update(participants_params)
    if @participant.save
      redirect_to project_participants_path(@participant.project), notice: "#{@participant.user.name}'s status is now #{@participant.status}."
    else
      render :new, notice: "Somethig went wrong, please try again."
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @participant = Participant.find(params[:participant_id])
    @participant.destroy
    redirect_to project_participants_path(@project.id), notice: "#{@participant.user.name} left #{@project.name}."
  end

  def pundit_policy_scoped?
    true
  end

  def pundit_policy_authorized?
    true
  end

  private

  def set_participant
    @project = Project.find(params[:project_id])
  end

  def set_participant_edit
    @project = Project.find(params[:project_id])
    @participant = Participant.find(params[:id])
  end

  def participants_params
    params.require(:participant).permit(:status)
  end
end
