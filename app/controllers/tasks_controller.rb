class TasksController < ApplicationController
  before_action :authenticate_request
  before_action :set_task, only: [ :show, :update, :destroy ]

  def index
    tasks = current_user.tasks.paginate(page: params[:page], per_page: 10)
    render json: tasks
  end

  def show
    render json: @task
  end

  def create
    task = current_user.tasks.new(task_params)
    if task.save
      render json: task, status: :created
    else
      render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    render json: { message: "Task deleted successfully" }, status: :ok
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :due_date)
  end
end
