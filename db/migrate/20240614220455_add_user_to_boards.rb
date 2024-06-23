class AddUserToBoards < ActiveRecord::Migration[7.1]
  def change
    add_reference :boards, :user, null: false, foreign_key: true
  end
end
