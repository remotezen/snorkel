class Login < ActiveRecord::Base
  belongs_to :user
  scope :users_logged_in, -> { where( login_status: true) }

  def User.user_logged_in?
    self.where(login_status: 1).lastest_login
  end
  
  private
    def latest_login
      order('created_at desc').first
    end
  def Login.login_stats
    self.where(login_status:true )
  end

end
