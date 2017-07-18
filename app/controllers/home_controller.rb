class HomeController < ApplicationController

  def index
  	@user = User.new
    @question = Question.new
  end

end
