class DummyMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.dummy_mailer.index.subject
  #
  def index
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
