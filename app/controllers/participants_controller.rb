class ParticipantsController < ApplicationController
  # before_action :authenticate_user!, except: %i[index]
  # before_action :set_participant, only: %i[index new create]

  def index
    @participants = Participant.where(project_id: @project.id)
  end

  def new
    @participant = Participant.create(project_id: params[:project_id], user_id: params[:user_id], participant_id: @current_participant.id, invited_at: DateTime.now)
  end

  def create
    @current_participant = Participant.where(project_id: params[:project_id], user_id: current_user.id).first
    join_request_user = JoinRequest.where
    @participant = Participant.create(project_id: params[:project_id], user_id: params[:user_id], participant_id: @current_participant.id, invited_at: DateTime.now)
    if @participant.save
      redirect_to project_path(params[:project_id]), notice: "#{@participant.user.name} is now a project participant"
    else
      render :new
    end
  end

  private

  def set_participant
    @project = Project.find(params[:project_id])
  end

  def participants_params
    params.require(:participants).permit(:project_id, :user_id)
  end
end
