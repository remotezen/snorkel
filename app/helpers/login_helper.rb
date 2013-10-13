module LoginHelper
  def set_login_cookie
    cookies.permanent[:login_attempts] = 0
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
  def last_login
    current_user.logins.last.created_at
  end
  def logged_in?
    current_user.logins.last.login_status
  end
  def login_user
    current_user.logins.last
  end
  def how_many_logins
    current_user.logins.count
  end
  def how_long_logged_in 
   (Time.now - login_user.created_at.to_time)/1.day 
  end
  def users_logins_in
  end
  
  
end
