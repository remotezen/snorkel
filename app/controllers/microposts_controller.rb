class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create,:destroy]
  before_action :correct_user, only: :destroy
  def create
    regEx = /\A(@[\w]+[\s]+)([\w\s]+)\z/
    str = micropost_params[:content] 
    m = regEx.match(str)
    username = m[1]
    content  = m[2]
    if m.nil?
     @micropost = current_user.microposts.build(micropost_params)
     razor(@micropost)
    else
     reply_to(username,content) unless m.nil? 
    end
  end

  def new
  end

  def edit
  end
  def destroy
    @micropost.destroy
    redirect_to root_url

  end

  def update
  end
  private
    def micropost_params
      params.require(:micropost).permit(:content)
    end
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end


    def reply_to(username,content)
      username.slice!(0)
      user = User.find_by_username(username.squish) 
      if user.nil?
        flash[:error] = "no such user"
        redirect_to root_url
      else

      micro = micropost_params
      micro[:content]= content
      micro[:to]=user.id
      @micropost = current_user.microposts.build(micro)
      razor(@micropost)
      end
    end
    def razor(micropost)
      if @micropost.save
        flash[:success] = "Micropost create!"
        redirect_to root_url
      else
        @feed_items = []
        render 'static_pages/home'
      end

    end

end
