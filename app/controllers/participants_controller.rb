class ParticipantsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :find_project_id, only: [:index, :new, :create]

  def index
    @participants = Participant.where(project_id: @project.id)
  end

  def create
    @current_participant = Participant.where(project_id: params[:project], user_id: current_user.id)
    @participant = Participant.create(project_id: params[:project], user_id: params[:user], participant_id: @current_participant.id, invited_at: DateTime.now)
    if @participant.save
      redirect_to project_path(@participant.project), notice: "#{@participant.user.name} is now a project participant"
    else
      render :new
    end
  end

  private

  def find_project_id
    @project = Project.find(params[:project_id])
  end

  def participants_params
    params.require(:participants).permit(:project_id, :is_founder, :invited_at, :accepted_at, :clearence_level)
  end

end
