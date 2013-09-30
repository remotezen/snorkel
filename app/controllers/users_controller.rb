class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
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
  end
  
  def show
    @user = User.find(params[:id])
  end
  private
  def user_params
    params.require(:user).permit(:name,:email,:password,
                                 :password_confirmation)
  end
  def signed_in_user
    redirect_to sigin_url, notice: 
      "Please sign in." unless signed_in?
  end
  def  correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

end
