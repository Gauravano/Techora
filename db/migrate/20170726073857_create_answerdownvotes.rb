class CreateAnswerdownvotes < ActiveRecord::Migration
  def change
    create_table :answerdownvotes do |t|
      t.references :user, index: true, foreign_key: true
      t.references :answer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
