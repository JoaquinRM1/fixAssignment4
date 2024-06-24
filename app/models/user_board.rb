# app/models/user_board.rb
class UserBoard < ApplicationRecord
  belongs_to :user
  belongs_to :board
end
