class ProjectsController < ApplicationController
  def index
    @projects = Project.ongoing
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    @project.update(project_params)
    redirect_to project_path(@project)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.save
    redirect_to project_path(@project)
  end

  def destroy
    @project = Project.find(params[:id])
    @project.delete
    redirect_to root_path
  end

  private

  def project_params
    params.require(:project).permit(:name, :descripton, :target_pledge_amount, :pledging_ends_on, :website)
  end
end
