class UserAuthenticatedController < ApiController
  before_action :authenticate_user

  def authenticate_user
    access_token =  params["access_token"]
    user = User.find_by_access_token(access_token)

    unless user
      return response_data nil,"Please Login ",200
    end
  end

  def current_user
    @current_user
  end

end

