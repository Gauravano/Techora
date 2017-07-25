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
    @answerCount = Answer.where(user_id: current_user.id).count
  end

  def upload_image
    uploaded_file = params[:image]
    filename = SecureRandom.hex+'.'+uploaded_file.original_filename.split('.')[1]
    filepath = Dir.pwd+"/public/uploads/"+filename
    File.open(filepath,'wb') do |file|
      file.write(uploaded_file.read())
    end

    current_user.profile_picture = filename
    current_user.save!
    return redirect_to '/home/profile'
  end

end
