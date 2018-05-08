class AddColumnsToTodos < ActiveRecord::Migration[5.1]
  def change
  	add_column :todos, :status, :string
  	add_column :todos, :completion_time, :datetime
   end
end
