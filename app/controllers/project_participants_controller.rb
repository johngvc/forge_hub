class ProjectParticipantsController < ApplicationController
  before_action :find_projectid, only: %i[index new]
  
  def index
    @participants = ProjectParticipant.where(project_id: @project.id)
  end
  def new
    @project_participants = ProjectParticipant.new
  end
  def create
    @project_participants = ProjectParticipant.new(project_participants_params)
    @project_participants.user = current_user
    @project_participants.project = Project.find(params[:project_id])
    if @project_participants.save
      redirect_to project_path(@project_participants.project), notice: "User is now a project participant, message sent"
    else
      render :new
    end
  end

  private
  def find_projectid
    @project = Project.find(params[:project_id])
  end
  def project_participants_params
    params.require(:project_participants).permit(:project_id, :is_founder, :inivted_on, :accepted_on, :clearence_level)
  end

end
