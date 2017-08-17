class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1
  # GET /answers/1.json
  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
  end

  def upvote

    flag = false
    @answerup = Answer.find(params[:answer_id])
    if ((current_user.role == "member") && (Answerupvote.isupvoted @answerup ,current_user))
    @upvote = Answerupvote.new
    @upvote.answer_id = @answerup.id
    @upvote.user_id = current_user.id
    @upvote.save
      flag = true

    end

  respond_to do |format|
    # format.html{
    #   redirect_to '/',notice: 'Answer is successfully upvoted'
    # }
    format.js {
      @count = @answerup.answerupvotes.length
      @check = flag
    }
  end
end


  # def downvote
  #   if ((current_user.role == "member") && (Answerdownvote.isdownvoted @answer ,current_user))
  #     @downvote = Answerdownvote.new
  #     @downvote.answer_id = @answer.id
  #     @downvote.user_id = current_user.id
  #     @downvote.save!
  #     redirect_to '/',notice: 'Answer is successfully voted down'
  #   else
  #     redirect_to '/',notice: 'You are not authorized to downvote Answers'
  #   end
  #
  # end

  def downvote

    flag = false
    @answerdown = Answer.find(params[:answer_id])
    if ((current_user.role == "member") && (Answerdownvote.isdownvoted @answerdown ,current_user))
      @downvote = Answerdownvote.new
      @downvote.answer_id = @answerdown.id
      @downvote.user_id = current_user.id
      @downvote.save
      flag = true

    end

    respond_to do |format|
      # format.html{
      #   redirect_to '/',notice: 'Answer is successfully upvoted'
      # }
      format.js {
        @count = @answerdown.answerdownvotes.length
        @check = flag
      }
    end
  end

  # POST /answers
  # POST /answers.json

  def create
  if current_user.member?
    @answer = Answer.new(answer_params)
    @answer.user_id = current_user.id
    @answer.question_id = params[:questid]
    respond_to do |format|
      if @answer.save
        AnswerMailer.answer_email(@answer.question.user,@answer.user).deliver_now
        format.html { redirect_to '/', notice: 'Answer was successfully created.' }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { render :new }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end

  else
    respond_to do |format|
      format.html { redirect_to '/',notice: 'You are not authorized to answer questions' }
      format.json { render json: @answer.errors, status: :unprocessable_entity }
    end

  end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    if current_user.role =="admin" || current_user.role =="editor" || current_user.id == @answer.user_id
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to '/', notice: 'Answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
    else
      respond_to do |format|
        format.html { redirect_to '/',notice: 'You are not authorized to update answer' }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end

    end
  end


  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    if current_user.role == "admin" ||current_user.role=="editor" ||current_user.id == @answer.user.id
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to '/', notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
    else
      respond_to do |format|
        format.html { redirect_to '/',notice: 'You are not authorized to delete answer' }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:ans, :user_id, :question_id)
    end
end
