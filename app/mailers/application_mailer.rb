class ApplicationMailer < ActionMailer::Base
  default from: ENV['GMAIL_SMTP_USER']
  layout 'mailer'
end
