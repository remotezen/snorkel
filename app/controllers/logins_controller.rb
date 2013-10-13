class LoginsController < ApplicationController
  def index 
    @login_items  = Login.login_stats.paginate(page: params[:page])
  end
end
