module SessionsHelper
  
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: 
      "Please sign in." unless signed_in?
    end
  end
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    cookies.delete :login_attempts
    @login = user.logins.build(login_status: true)
    @login.save!
    
    self.current_user = user
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end
  def signed_in?
    !current_user.nil?
  end
  def last_login
    current_user.logins.last.created_at
  end
  def logged_in?
    user = current_user 
    user.logins.last.login_status
  end
  def sign_out
    @login = login_user.update_attribute(:login_status, false)
    self.current_user  = nil
    cookies.delete(:remember_token)
  end
  def current_user?(user)
    user == current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end
  def store_location
    session[:return_to] = request.url if request.get?
  end
end
