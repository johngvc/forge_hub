class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end
  def show
    @project = Project.find(params[:user_id])
  end
  def new
    
  end
  def create
    
  end
  def edit
    
  end
  def update
    
  end
  def destroy
    
  end
end
