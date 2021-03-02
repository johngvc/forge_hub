class ProjectsController < ApplicationController
  before_action :find_id, only: %i[show edit update]
  
  def index
    @projects = Project.all
    @user = current_user
  end
  def show
    @project = Project.find(params[:id])
  end
  def new
    @project = Project.new
  end
  def create
    @project = Project.new(projects_params)
    @project.user = current_user
    if @project.save
      redirect_to project_path(@project)
    else
      render :new, notice: "Something went wrong. Try again "
    end
  end
  def edit
    show
  end
  def update
    show
    @project = Project.find(projects_params)
    @project.update = (projects_params)
    if @project.save
      redirect_to project_path(@project)
    else
      render :new, notice: "Something went wrong. Try again "
    end
  end
  def destroy
    
  end

  private

  def find_id
    @project = Project.find(params[:id])
  end

  def projects_params
    params.require(:project).permit(:name, :description, :linkedin_url, :github_url, :trello_url)
  end
end
