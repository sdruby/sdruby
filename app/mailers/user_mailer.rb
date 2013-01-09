class UserMailer < ActionMailer::Base
  default from: "SD Ruby <no-reply@sdruby.org>"

  def forgot_password(to, pass)
    @pass = pass
    mail(:to => to,
         :reply_to => "SD Ruby <no-reply@sdruby.org>",
         :subject => "Password reset for SD Ruby")
  end

end
