class RegistrationMailer < ActionMailer::Base
  default from: "6.115-tas@mit.edu"
  
  def welcome_email(user,password)
    @username = user.username
    @password = password
    mail(:to => user.email, :subject => "Welcome to 6.115")
  end
end
