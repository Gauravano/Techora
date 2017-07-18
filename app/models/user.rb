class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
<<<<<<< HEAD
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable,:confirmable
=======
         :recoverable, :rememberable, :trackable, :validatable,:confirmable


  def feed
    users = User.all
    Question.where(user_id: users).order(created_at: :desc)
  end


>>>>>>> project
end
