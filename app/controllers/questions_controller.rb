class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:show, :update, :destroy,:edit]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json

  # GET /questions/new
  def new
    @question = Question.new
  end

  def edit
  end

  # GET /questions/1/edit
  # POST /questions
  # POST /questions.json
  # def create
  #   # if user_signed_in?
  #   @question = Question.new(question_params)
  #
  #   respond_to do |format|
  #     if @question.save
  #     else
  #       format.html { render :new }
  #       format.json { render json: @question.errors, status: :unprocessable_entity }
  #     end
  #   end
  #   # else
  #   #   before_filter :authenticate_user!
  #   #  end
  #
  # end

  def create

if current_user.member?
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    respond_to do |format|
      if @question.save
        format.html { redirect_to '/', notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
        format.js{ @answer = Answer.new }
      else
        format.html { render 'home/index' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
else
  respond_to do |format|
    format.html { redirect_to '/',notice: 'You are not authorized to create question' }
    format.json { render json: @question.errors, status: :unprocessable_entity }
  end
end

  end

  def update
  if current_user.role == "admin" || current_user.id == @question.user_id
      respond_to do |format|
        if @question.update(question_params)
          format.html { redirect_to '/', notice: 'Question was successfully updated.' }
          format.json { render :show, status: :ok, location: @question }
        else
          format.html { render :edit }
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      end
  else
    respond_to do |format|
      format.html { redirect_to '/',notice: 'You are not authorized to update question' }
      format.json { render json: @question.errors, status: :unprocessable_entity }
    end
  end
end


  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    if current_user.role == "admin" || current_user.role=="editor" || current_user.id == @question.user_id
    @question.destroy
    respond_to do |format|
      format.html { redirect_to '/', notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
    else
      respond_to do |format|
        format.html { redirect_to '/',notice: 'You are not authorized to delete question' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:content, :user_id, :anonymous)
    end
end
