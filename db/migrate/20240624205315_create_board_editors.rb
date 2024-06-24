class CreateBoardEditors < ActiveRecord::Migration[7.1]
  def change
    create_table :board_editors do |t|
      t.references :user, null: false, foreign_key: true
      t.references :board, null: false, foreign_key: true

      t.timestamps
    end
  end
end
