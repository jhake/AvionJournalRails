class TasksController < ApplicationController
  def today
    @tasks_completed = Task.where(completed: true, deadline: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).order(deadline: :desc)
    @tasks_incomplete = Task.where(completed: false, deadline: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).order(deadline: :desc)
  end

  def index
    @tasks_completed = Task.where(completed: true).order(deadline: :desc)
    @tasks_incomplete = Task.where(completed: false).order(deadline: :desc)
  end

  def show
    @task = Task.find(params[:id])
    puts params
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new #(task_params)
    @task.name = params[:task][:name]
    @task.details = params[:task][:details]
    @task.deadline = params[:task][:deadline]
    @task.completed_at = params[:task][:completed_at]
    @task.completed = params[:task][:completed]
    @task.category_id = params[:task][:category_id]
    if @task.save
      flash[:success] = "Successfully created '#{@task.name}'!"
      redirect_to tasks_path
    else
      flash.now[:error] = "Invalid inputs!"
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(id: params[:id], name: params[:task][:name], details: params[:task][:details], deadline: params[:task][:deadline], completed_at: params[:task][:completed_at], completed: params[:task][:completed], category_id: params[:task][:category_id])
      flash[:success] = "Successfully edited '#{@task.name}'!"
      redirect_to tasks_path
    else
      flash.now[:error] = "Invalid inputs!"
      render :edit
    end
  end

  def delete
    @task = Task.find(params[:id])
    if @task.destroy
      flash[:success] = "Successfully deleted '#{@task.name}'!"
      redirect_to tasks_path
    else
      render :edit
    end
  end

  private

  #strong parameter
  def task_params
    params.require(:task).permit(:name, :details, :deadline, :started_at, :completed_at, :started, :completed, :category_id)
  end
end
