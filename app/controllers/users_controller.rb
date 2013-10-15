class UsersController < ApplicationController
  before_action :signed_in_user, 
    only: [:index, :edit, :update, :following, :followers]
  before_action :correct_user, 
    only: [:edit, :update]
  before_action :admin_user, 
    only: :destroy
  before_action :limit_signed_in_user,
    only: [:new, :create]

  def index
    @users = User.paginate(page: params[:page])
  end

 def create 
    @user = User.new(user_params)
    if @user.save
      sign_in @user

      flash[:success] = "Start Snorkeling"
      redirect_to @user
    else
      render 'new'
    end
  end
  def update
    if @user.update_attribute(user_params)
      flash[:success] = "Profile updated"
    else
      render 'edit'
    end
  end
  def destroy
    user = User.find(params[:id])
    unless user.admin?
      user.destroy
      flash[:success] = "User #{ user.name } id #{user.id } nuked"
      redirect_to users_url
    else  
      flash[:error] = "Admin users can't nuke themselves"
      redirect_to current_user
    end
  end
  def new
    @user = User.new
  end
  
  def edit
  end
  def update
      @user = User.find(params[:id])
      if @user.update_attributes(user_params)
        flash[:success] = "Profile updated"
        redirect_to @user
      else
        render 'edit'
      end
  end
  
  def show

    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'

  end
  private
  def limit_signed_in_user
    redirect_to root_url unless !signed_in?

  end
  def user_params
    params.require(:user).permit(:name,:email,:password,
                    :password_confirmation) if params[:user]
  end
  def  correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  def admin_user
   redirect_to(root_url) unless current_user.admin?
  end

end

