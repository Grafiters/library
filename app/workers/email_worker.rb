class EmailWorker
    include Sidekiq::Worker
  
    def perform(user = nil, title, subject, content, template)
        param_mail = {
            user: user,
            content: content,
            subject: subject,
            title: title,
            template: template
        }

        MailMailer.mailer(param_mail).deliver_now
    rescue => e
        puts "++++++++++++++++++++"
        puts e.inspect
        puts "++++++++++++++++++++"
    end
end