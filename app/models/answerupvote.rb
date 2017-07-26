class Answerupvote < ActiveRecord::Base
  belongs_to :user
  belongs_to :answer

  def self.isupvoted answer,user
byebug
    if Answerupvote.where(user_id: user.id,answer_id: answer.id).length > 0
      return false
    else
      return true
    end

  end


end
