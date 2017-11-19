class ProjectsController < ApplicationController
  before_action :authenticate_member!

  def index
    @projects = Project.all.order(updated_at: :desc).page(params[:page])
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @member = current_member
    @project = Project.new(project_params)
    @project.creator_id = @member.id

    if @project.save
      @member.projects << @project
      flash[:success] = 'Your project has been successfully created!'
      redirect_to @project
    else
      render 'new'
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
