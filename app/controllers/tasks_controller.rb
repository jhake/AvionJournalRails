class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :get_category

  def today
    @tasks_completed = Task.where(user_id: current_user.id, completed: true, deadline: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).order(deadline: :desc)
    @tasks_incomplete = Task.where(user_id: current_user.id, completed: false, deadline: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).order(deadline: :desc)
  end

  def index
    if @category
      @tasks_completed = Task.where(user_id: current_user.id, completed: true, category_id: @category.id).order(deadline: :desc)
      @tasks_incomplete = Task.where(user_id: current_user.id, completed: false, category_id: @category.id).order(deadline: :desc)
    else
      @tasks_completed = Task.where(user_id: current_user.id, completed: true).order(deadline: :desc)
      @tasks_incomplete = Task.where(user_id: current_user.id, completed: false).order(deadline: :desc)
    end
  end

  def show
    @task = Task.where(user_id: current_user.id).find(params[:id])
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
    @task.user_id = current_user.id
    if @category
      @task.category_id = params[:category_id]
    else
      @task.category_id = params[:task][:category_id]
    end
    if @task.save
      flash[:success] = "Successfully created '#{@task.name}'!"
      if @category
        redirect_to category_tasks_path
      else
        redirect_to tasks_path
      end
    else
      flash.now[:error] = "Invalid inputs!"
      render :new
    end
  end

  def edit
    @task = Task.where(user_id: current_user.id).find(params[:id])
  end

  def update
    @task = Task.where(user_id: current_user.id).find(params[:id])
    if @category
      category_id = @category.id
    else
      category_id = params[:task][:category_id]
    end
    if @task.update(id: params[:id], name: params[:task][:name], details: params[:task][:details], deadline: params[:task][:deadline], completed_at: params[:task][:completed_at], completed: params[:task][:completed], category_id: category_id, user_id: current_user.id)
      flash[:success] = "Successfully edited '#{@task.name}'!"   
      if @category
        redirect_to category_tasks_path
      else
        redirect_to tasks_path
      end
    else
      flash.now[:error] = "Invalid inputs!"
      render :edit
    end
  end

  def destroy
    @task = Task.where(user_id: current_user.id).find(params[:id])
    if @task.destroy
      flash[:success] = "Successfully deleted '#{@task.name}'!"
      if @category
        redirect_to category_tasks_path
      else
        redirect_to tasks_path
      end
    else
      render :edit
    end
  end

  private

  def get_category
    if params[:category_id]
      @category = Category.find(params[:category_id])
    end
  end

  #strong parameter
  def task_params
    params.require(:task).permit(:name, :details, :deadline, :started_at, :completed_at, :started, :completed, :category_id)
  end
end
