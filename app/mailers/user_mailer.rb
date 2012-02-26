class UserMailer < ActionMailer::Base
  default from: "SD Ruby <sandiegoruby@gmail.com>"

  def forgot_password(to, pass)
    @pass = pass
    mail(:to => to,
         :reply_to => "SD Ruby <sandiegoruby@gmail.com>",
         :subject => "SD Ruby => Password Reset")
  end

end
