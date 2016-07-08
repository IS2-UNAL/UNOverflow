class PageMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.page_mailer.received.subject
  #
  def received(email,comments)
    @email = email
    @comments = comments

    mail to: @email,subject:'Comments' ,bcc:"agutierrezt@unal.edu.co"
  end
end
