class StatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_state, only: [:show, :edit, :update, :destroy]
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @states = State.all
  end

  def show; end

  def new
    @board = Board.find(params[:board_id])
    @state = @board.states.new
  end

  def create
    @board = Board.find(params[:board_id])
    @state = @board.states.new(state_params)
    if @state.save
      redirect_to @board, notice: 'State was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @state.update(state_params)
      redirect_to @state, notice: 'State was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @state.destroy
    redirect_to @board, notice: 'State was successfully deleted.'
  end

  private

  def set_state
    @state = State.find(params[:id])
  end

  def set_board
    @board = @state.board
  end

  def state_params
    params.require(:state).permit(:state_name, :board_id)
  end

  def authorize_user!
    redirect_to boards_path, alert: 'You are not authorized to perform this action.' unless @board.user == current_user
  end
end
