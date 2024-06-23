class CreateStates < ActiveRecord::Migration[7.1]
  def change
    create_table :states do |t|
      t.string :state_name
      t.references :board, null: false, foreign_key: true

      t.timestamps
    end
  end
end
