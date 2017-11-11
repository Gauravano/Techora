# Preview all emails at http://localhost:3000/rails/mailers/answer
class AnswerPreview < ActionMailer::Preview
  def answer_email
    @user = User.first
    @answeredby  = User.second
    AnswerMailer.answer_email(@user,@answeredby);
  end
end
