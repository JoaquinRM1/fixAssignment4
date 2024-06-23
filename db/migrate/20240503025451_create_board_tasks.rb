class CreateBoardTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :board_tasks do |t|
      t.references :board, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
