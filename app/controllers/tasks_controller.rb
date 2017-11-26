class TasksController < ApplicationController

def new
  @project = Project.find(params[:id])
  @task = Task.new
end

end
