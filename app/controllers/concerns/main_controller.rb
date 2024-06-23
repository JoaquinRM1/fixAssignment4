class MainController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    @latest_boards = Board.order(created_at: :desc).limit(3)
  end
end
