class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  validates :ans,presence: true,length: {maximum: 20}
end
