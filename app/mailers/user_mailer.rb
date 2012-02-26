class UserMailer < ActionMailer::Base
  default from: "SD Ruby <contact@sdruby.org>"

  def forgot_password(to, pass)
    @pass = pass
    mail(:to => to,
         :reply_to => "SD Ruby <contact@sdruby.org>",
         :subject => "SD Ruby - Password Reset")
  end

end
