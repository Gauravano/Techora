class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  validates :content,presence: true,length: {minimum: 10,maximum: 200}

  def listans question_id
    return Answer.where(question_id: question_id)
  end

end
