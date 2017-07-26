class AddUpvotesToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :upvotes, :integer,default: 0
  end
end
