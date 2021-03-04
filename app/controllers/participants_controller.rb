class ParticipantsController < ApplicationController
  # before_action :authenticate_user!, except: %i[index]
  before_action :set_participant, only: %i[new create edit]

  def index
    @project = Project.find(params[:project_id])
    @participants = Participant.where(project_id: @project.id)
    @current_participant = Participant.where(project_id: @project.id, user_id: current_user.id).first
  end

  def new
    @participant = Participant.create(project_id: params[:project_id], user_id: params[:user_id], participant_id: @current_participant.id, invited_at: DateTime.now)
  end

  def create
    @invite_participant = Participant.where(project_id: params[:project_id], user_id: current_user.id).first
    @participant = Participant.create(project_id: params[:project_id], user_id: params[:user_id], invite_participant_id: @invite_participant.id, invited_at: DateTime.now)
    if @participant.save
      redirect_to project_participants_path(params[:project_id]), notice: "#{@participant.user.name} is now a project participant"
    else
      render :new
    end
  end

  def edit
    @invite_participant = Participant.find(@participant.invite_participant_id)
  end


  private

  def set_participant
    @project = Project.find(params[:project_id])
    @participant = Participant.find(params[:id])
  end

  def participants_params
    params.require(:participants).permit(:project_id, :user_id)
  end
end
