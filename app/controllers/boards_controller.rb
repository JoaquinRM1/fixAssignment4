class BoardsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_board, only: [:show, :edit, :update, :destroy, :manage_editors, :add_editor, :remove_editor]
  before_action :authorize_user!, only: [:edit, :update, :destroy, :manage_editors, :add_editor, :remove_editor]

  def index
    @boards = Board.all
    @tasks = Task.all
  end

  def show
    @tasks = Task.where(board_id: @board.id)
    @states = State.where(board_id: @board.id)
  end

  def new
    @board = current_user.boards.new
  end

  def create
    @board = current_user.boards.new(board_params)
    if @board.save
      redirect_to boards_path, notice: 'Board was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @board.update(board_params)
      redirect_to boards_path, notice: 'Board was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @board.destroy
    redirect_to boards_path, notice: 'Board was successfully deleted.'
  end

  def manage_editors
    @users = User.all - @board.editors
  end

  def add_editor
    user = User.find(params[:user_id])
    @board.editors << user
    redirect_to manage_editors_board_path(@board), notice: "#{user.email} can now edit this board."
  end

  def remove_editor
    user = User.find(params[:user_id])
    @board.editors.delete(user)
    redirect_to manage_editors_board_path(@board), notice: "#{user.email} can no longer edit this board."
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:board_name)
  end

  def authorize_user!
    redirect_to boards_path, alert: 'You are not authorized to perform this action.' unless @board.user == current_user || @board.editors.include?(current_user)
  end
end
