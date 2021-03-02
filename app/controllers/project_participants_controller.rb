class ProjectParticipantsController < ApplicationController
  
  def index
    @project = Project.find(params[:id])
    @participants = @project.participants
  end
end
