class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:edit, :update, :destroy]
  before_action :set_board_and_state, only: [:new, :create]

  def index
    @tasks = Task.all  # Ensure @tasks is initialized
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = @state.tasks.new
    @task.board = @board
  end

  def create
    @task = @state.tasks.new(task_params)
    @task.user = current_user
    @task.board = @board

    if @task.save
      redirect_to [@board, @state], notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to [@task.board, @task.state], notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to [@task.board, @task.state], notice: 'Task was successfully deleted.'
  end

  def move
    task_ids = params[:task_ids]
    new_state_id = params[:new_state_id]

    Rails.logger.debug "Moving tasks: #{task_ids.inspect} to new state: #{new_state_id}"

    if task_ids.present? && new_state_id.present?
      begin
        tasks = Task.where(id: task_ids)
        tasks.update_all(state_id: new_state_id)
        Rails.logger.debug "Tasks moved successfully: #{tasks.pluck(:id)}"
        render json: { success: true }, status: :ok
      rescue => e
        Rails.logger.error "Error moving tasks: #{e.message}\n#{e.backtrace.join("\n")}"
        render json: { error: e.message }, status: :unprocessable_entity
      end
    else
      Rails.logger.error "Invalid parameters: task_ids=#{task_ids}, new_state_id=#{new_state_id}"
      render json: { error: 'Invalid parameters' }, status: :unprocessable_entity
    end
  end

  def simple_ajax
    render json: { message: "AJAX request received!" }
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def set_board_and_state
    @board = Board.find(params[:board_id])
    @state = State.find(params[:state_id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :state_id, :priority, :status)
  end
end
