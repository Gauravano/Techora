class ApiController < ActionController::API

  def response_data data,message,status
      data = {
          data: data,
          message: message,
      }

    render json: data,status: status
  end

end