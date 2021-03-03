class ProjectsController < ApplicationController
  before_action :find_id, only: %i[edit update destroy]

  def index
    @projects = Project.all
    @user = current_user
  end
  def show
    @project = Project.find(params[:id])
    @participants = Participant.where(project_id: @project[:id])
  end
  def new
    @project = Project.new
  end
  def create
    @project = Project.new(projects_params)
    project_id = @project[:id]
    @project.user = current_user
    if @project.save
      create_participant(@project)
    else
      raise
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

  # def create_participant(project)
  #   @project_participant = ProjectParticipant.new(user_id: current_user.id, project_participant_id: 1, project_id: project[:id], is_founder: true, invited_on: DateTime.now, accepted_on: DateTime.now)
  #   @project_participants.user = current_user
  #   if @project_participant.save
  #     notice: "User is now a project participant"
  #   else
  #     notice: "something went wrong, user not saved as a project participant"
  #   end
  # end

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
    @project.destroy
    redirect_to projects_path
  end

  private

  # def participants_params
  #   params.require(:project).permit(user_id: current_user.id, project_participant_id: 1, project_id: @project.id, is_founder: true, invited_on: DateTime.now, accepted_on: DateTime.now)
  # end
  def find_id
    @project = Project.find(params[:id])
  end

  def projects_params
    params.require(:project).permit(:name, :description, :linkedin_url, :github_url, :trello_url)
  end
end
