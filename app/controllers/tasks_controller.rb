class TasksController < ApplicationController
  before_action :authenticate_member!

  def show
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
  end

  def new
    @project = Project.find(params[:project_id])
    @task = Task.new(project_id: @project.id)
  end

  def create
    @project = Project.find(params[:project_id])
    @task = Task.new(task_params)
    @task.project_id = @project.id

    if @task.save
      flash[:success] = 'Your task has been successfully created!'
      redirect_to @project
    else
      render 'new'
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :keywords, :needs)
  end
end
