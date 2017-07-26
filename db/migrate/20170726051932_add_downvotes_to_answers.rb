class AddDownvotesToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :downvotes, :integer,default: 0
  end
end
