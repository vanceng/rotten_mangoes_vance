class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end


  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User has been deleted!"
    redirect_to admin_users_path
  end


  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

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