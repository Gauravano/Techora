class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :coverpic, :string
  end
end
