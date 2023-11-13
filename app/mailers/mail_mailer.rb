class MailMailer < ApplicationMailer
    def mailer(params)
        @user = params[:user]
        @content = params[:content]
        @subject = params[:subject]
        @template = params[:template]
        @title = params[:title]

        if params[:user].nil?
            user_list = User.all
            user_list.each do |user|
                @user_data = user.as_json_email
                option_params = {
                    subject: @subject,
                    template_name: @template,
                    to: user[:email]
                }

                puts @content[:title]
                puts mail(option_params)
            end
        else
            option_params = {
                subject: @subject,
                template_name: @template,
                to: @user[:email]
            }

            mail(option_params)
        end
    rescue => e
        puts "============================"
        puts e.inspect
        puts "============================"
    end
end