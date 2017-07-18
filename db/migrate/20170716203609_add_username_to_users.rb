class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :school, :string
    add_column :users, :jobstat, :string
    
  end
end
