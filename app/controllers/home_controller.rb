class HomeController < ApplicationController

  def index
  	@user = User.new
    @question = Question.new
    @answer = Answer.new
    @feed = Question.all.order(created_at: :desc)

  end

  def users
    @users = User.all
  end

  def profile

  end

  def uploadImage

  end

end
