class AddUserIdToTasks < ActiveRecord::Migration[7.1]
  def change
    add_reference :tasks, :user, foreign_key: true, null: false, default: 1
  end
end
