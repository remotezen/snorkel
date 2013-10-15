class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create,:destroy]
  before_action :correct_user, only: :destroy
  def create
    @micropost = current_user.microposts.build(micropost_params)

      regEx = /\A(@[\w]+[\s]+)([\w\s]+)\z/
      reply_to($1,$2) if  micropost_params[:content].to_s =~ regEx 
      razor(@micropost)
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
      name = username.to_s.slice(0).squish
      user = User.find_by_username(name)
      hsh = HashWithIndifferentAccess.new(to: user.id)
      micropost_params[:content] = content
      micropost_params.merge!(hsh)
      @micropost = current_user.microposts.build(micropost_params)
      razor(@micropost)
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
