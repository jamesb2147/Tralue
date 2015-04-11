class Notifier < ActionMailer::Base
  default from: "shunter@tralue.com"
  
  def password_reset
    @user = user
    mail(to: "#{ user.given_name } #{ user.family_name } <#{ user.email }", subject: "Tralue - Reset your password" )
    
  end
end
