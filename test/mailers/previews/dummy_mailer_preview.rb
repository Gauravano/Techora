# Preview all emails at http://localhost:3000/rails/mailers/dummy_mailer
class DummyMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/dummy_mailer/index
  def index
    DummyMailer.index
  end

end
