class TasksController < ApplicationController
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_url, notice: "Task was successfully updated" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task_description = @task.description
    @task.destroy
    redirect_to tasks_url, notice: @task_description + " was successfully deleted."
  end

  def index
    @tasks = Task.all
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save and @task.description
        format.html { redirect_to tasks_url, notice: 'Task was successfully created' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def toggle
    @task = Task.find(params[:id])
    @task.update(completed: params[:completed])

  end

  private

  def task_params
    params.require(:task).permit(:description)
  end
end
