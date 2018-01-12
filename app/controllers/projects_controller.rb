class ProjectsController < ApplicationController
  before_action :authenticate_member!

  def index
    @projects = Project.all.order(updated_at: :desc).page(params[:page])
  end

  def show
    @member = current_member
    @project = Project.find(params[:id])
    @tasks = @project.tasks.order(updated_at: :desc).page(params[:page])
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

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])

    if @project.update_attributes(project_params)
      flash[:notice] = 'Your project has been successfully updated!'
      redirect_to @project
    else
      render 'edit'
    end
  end

  def join
    @member = current_member
    @project = Project.find(params[:id])

    if @project.members << @member
      flash[:notice] = 'You have successfully joined the project!'
      redirect_to @project
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.project_memberships.clear
    @project.destroy
    flash[:notice] = 'Your project has been successfully deleted!'
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
