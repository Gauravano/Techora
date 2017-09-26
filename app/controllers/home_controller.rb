class HomeController < ApplicationController

  def index
  	@user = User.new
    @question = Question.new
    @answer = Answer.new
    if current_user
      @feed = current_user.feed
    else
      @feed = Question.all.order(created_at: :desc)
    end

  end

  def follow
    followee_id = params[:followee_id]
    if current_user.can_follow followee_id
      FollowMapping.create(:followee_id => followee_id, :follower_id => current_user.id)
    else
    end
    return redirect_to '/users'
  end

  def unfollow
    followee_id = params[:followee_id]
    if current_user.can_unfollow followee_id
      FollowMapping.where(:followee_id => followee_id, :follower_id => current_user.id).first.destroy
    else
    end
    return redirect_to '/users'
  end

  def users
    @users = User.all
  end

  def profile
    @answerCount = Answer.where(user_id: current_user.id).count

    if @answerCount.nil?
      @answerCount = 1
    end
  end

  def upload_image
    uploaded_file = params[:image2]
    filename = SecureRandom.hex+'.'+uploaded_file.original_filename.split('.')[1]
    filepath = Dir.pwd+"/public/uploads/"+filename
    File.open(filepath,'wb') do |file|
      file.write(uploaded_file.read())
    end

    current_user.profile_picture = filename
    current_user.save!
    return redirect_to '/home/profile'
  end

  def upload_coverpic
    uploaded_file = params[:image1]
    filename = SecureRandom.hex+'.'+uploaded_file.original_filename.split('.')[1]
    filepath = Dir.pwd+"/public/uploads/"+filename
    File.open(filepath,'wb') do |file|
      file.write(uploaded_file.read())
    end

    current_user.coverpic = filename
    current_user.save!
    return redirect_to '/home/profile'
  end

end
