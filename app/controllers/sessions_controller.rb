class SessionsController < ApplicationController
  def  new
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
       login_cookie
      flash.now[:error] = "Invalid email/password combination 
      #{view_context.pluralize(login_failures,'failure')} to login"
      
      render 'new'
    end
  end
  def destroy
    sign_out
    redirect_to root_url
  end
  private
  def login_cookie 
    if failed_login?
      set_login_count
    else
      failed_login
    end
  end
end
