class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

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
    @user = User.find(params[:id])
    if @user.update_attribute(user_params)
      flash[:success] = "Profile updated"
    else
      render 'edit'
    end
  end
  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = "User #{ user.name } id #{user.id } nuked"
    redirect_to users_url
  end
  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
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
  end
  private
  def user_params
    params.require(:user).permit(:name,:email,:password,
                    :password_confirmation) if params[:user]
  end
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: 
      "Please sign in." unless signed_in?
    end
  end
  def  correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

end
