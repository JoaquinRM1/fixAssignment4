class CreateStates < ActiveRecord::Migration[7.1]
  def change
    create_table :states do |t|
      t.references :board, foreign_key: true
      t.string :state_name
      t.timestamps
    end
  end
end
