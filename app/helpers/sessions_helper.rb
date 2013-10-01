module SessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
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
  def set_login_cookie
    cookies.permanent[:login_attempts] = 0
  end
  def sign_out
    self.current_user  = nil
    cookies.delete(:remember_token)
  end
  def failed_login
    num_login = cookies[:login_attempts].to_f 
    num_login += 1
    cookies[:login_attempts] = num_login 
  end
  def failed_login?
    cookies[:login_attempts].blank?
  end
  def login_failures
    failed_logins = cookies[:login_attempts]
    return failed_logins.to_i
  end
  def set_login_count
    cookies[:login_attempts] = 1
  end
end
