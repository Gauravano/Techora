# Preview all emails at http://localhost:3000/rails/mailers/dummy
class DummyPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/dummy/index
  def index
    Dummy.index
  end

end
