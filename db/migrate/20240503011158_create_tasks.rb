class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.references :board, foreign_key: true
      t.references :state, foreign_key: true
      t.string :title
      t.text :description
      t.references :informer, foreign_key: { to_table: :users }
      t.references :assignee, foreign_key: { to_table: :users }
      t.references :user, foreign_key: true # Agregar columna user_id
      t.string :status
      t.integer :priority
      t.timestamps
    end
  end
end
