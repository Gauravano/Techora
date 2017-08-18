class UserApiController < UserAuthenticatedController

  def signup
    user_email = params["email"]
    password = params["password"]
  end

  def signin
    user_email = params["email"]
    password = params["password"]

    user = User.find_by_email(user_email)

    unless user
      data = {}
      data["message"] = "Please SignUp"
      render json: data
    end




  end

  def verify_user
    data["access_token"] = user.access_token
    return response_data data, "You are logged in", 200
  end

  def logout

  end

end