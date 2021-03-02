class ProjectsController < ApplicationController
  before_action :find_id, only: %i[show edit update destroy]

  def index
    @projects = Project.all
    @user = current_user
  end
  def show
    @participants = ProjectParticipant.find(project_id: @project.id)
  end
  def new
    @project = Project.new
  end
  def create
    @project = Project.new(projects_params)
    @project.user = current_user
    if @project.save
      ProjectParticipant.create(user_id: current_user.id, project_participant_id: 1, project_id: @project.id, is_founder: true, invited_on: DateTime.now, accepted_on: DateTime.now)
      redirect_to project_path(@project)
    else
      render :new, notice: "Something went wrong. Try again "
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
