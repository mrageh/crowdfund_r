class PledgesController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @pledges = @project.pledges.all
  end

  def new
    @project = Project.find(params[:project_id])
    @pledge = @project.pledges.new
  end

  def  create
    @project = Project.find(params[:project_id])
    @pledge = @project.pledges.create(pledge_params)
    if @pledge.save
      redirect_to project_pledges_path(@project), notice: "Thanks for pledging!"
    else
      render :new
    end
  end

  private

  def pledge_params
    params.require(:pledge).permit(:amount, :comment, :email, :name)
  end
end
