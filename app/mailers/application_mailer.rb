class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('SMTP_SENDER')
end