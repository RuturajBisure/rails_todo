class AddColumnToUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :phone, :string
  	add_column :users, :username, :string, unique: true
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
  end
end
