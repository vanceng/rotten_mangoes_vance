class Admin::UsersController < ApplicationController

before_filter :authorized?

    
  def index
    @admins = User.where(admin: true).page(params[:page]).per(1)
    @users = User.where(admin: false).page(params[:page]).per(1)
  end

  def show
    @users = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
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

end
