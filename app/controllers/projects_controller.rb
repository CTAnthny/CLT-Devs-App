class ProjectsController < ApplicationController
  before_action :authenticate_member!
  before_action :set_member, only: [:show, :create, :join]
  before_action :set_project, except: [:index, :new, :create]

  def index
    @projects = Project.all.order(updated_at: :desc).page(params[:page])
  end

  def show
    @tasks = @project.tasks.order(updated_at: :desc).page(params[:page])
  end

  def new
    @project = Project.new
  end

  def create
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
  end

  def update
    if @project.update_attributes(project_params)
      flash[:notice] = 'Your project has been successfully updated!'
      redirect_to @project
    else
      render 'edit'
    end
  end

  def join
    if @project.members << @member
      flash[:notice] = 'You have successfully joined the project!'
      redirect_to @project
    end
  end

  def destroy
    @project.project_memberships.clear
    @project.destroy
    flash[:notice] = 'Your project has been successfully deleted!'
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def set_member
    @member = current_member
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
