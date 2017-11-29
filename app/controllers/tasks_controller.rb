class TasksController < ApplicationController
  before_action :authenticate_member!
  before_action :set_project
  before_action :set_task, except: [:new, :create]

  def show
  end

  def new
    @task = Task.new(project_id: @project.id)
  end

  def create
    @task = Task.new(task_params)
    @task.project_id = @project.id

    if @task.save
      flash[:success] = 'Your task has been successfully created!'
      redirect_to @project
    else
      render 'new'
    end
  end

  def edit
  end

  def update

    if @task.update_attributes(task_params)
      flash[:notice] = 'Your task has been successfully updated!'
      redirect_to [@project, @task]
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    flash[:notice] = 'Your task has been successfully deleted!'
    redirect_to @project
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :keywords, :needs)
  end

  def set_project
    raise "Project Not Found" unless params[:project_id]
    @project = Project.find(params[:project_id])
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
