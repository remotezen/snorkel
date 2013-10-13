class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  def welcome_email(user, other)
    @user = user
    @url = 'http://localhost:3000'
    #should be user.email
    mail(to: @user.email, 
         subject: "#{other.name } wants to hookup are you in"


  end
end
