class AddColumnStateToTask < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :state, :string
  end
end
