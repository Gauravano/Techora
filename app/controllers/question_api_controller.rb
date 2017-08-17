class QuestionApiController < ApiController


  def create
    if current_user.member?
      @question = Question.new
      @question.content = params["question"]
      @question.user_id = current_user.id

      if @question.save
        return response_data @question,"Question successfully created",200
      end
    else
      return response_data nil,"You are not authorized ",200
    end
  end


    def index
      data = {}
      data["questions"] = Question.all
      return response_data data,"Listing all Questions",200
    end

end