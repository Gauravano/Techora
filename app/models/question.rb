class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  validates :content,presence: true,length: {minimum: 10,maximum: 200}
end
