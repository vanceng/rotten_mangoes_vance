class Admin::UsersController < ApplicationController

before_filter :authorized?

    
  def index
    @admins = User.where(admin: true).page(params[:page]).per(1)
    @users_list = User.where(admin: false).page(params[:page]).per(1)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_users_path  
    else
      flash[:error] = "Was not able to save, please try again"
      redirect_to admin_users_path      
    end
  end


protected

  def authorized?
    if current_user
      unless current_user.admin == true 
        flash[:error] = "You are not authorized to view that page."
        redirect_to root_path
      end
    else
        flash[:error] = "Please log in."
        redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

end
