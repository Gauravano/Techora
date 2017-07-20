class HomeController < ApplicationController

  def index
  	@user = User.new
    @question = Question.new
    @feed = Question.all.order(created_at: :desc)

  end

  def users
    @users = User.all
  end
end
