class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :set_user, only: [:edit, :show, :update]

  def new
    @user = User.new
  end

  def show
    
  end

  def edit
    if !user_authenticated?(params[:id])
      redirect_to root_path
    end
  end

  def update
    if @user.update(user_params) && user_authenticated?(params[:id])
      redirect_to user_path(@user)
    else
      render 'users/edit'
    end
  end

  def create
    if params[:user]
      @user = User.new(user_params)
      if @user.valid?
        @user.save
        session[:user_id] = @user.id
        redirect_to root_path
      else
        render 'users/new'
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :real_name, :email, :password, :password_confirmation, :github_uid, :github_profile_url, :company, :bio, :avatar_url, :communication_method)
  end

  def set_user
    @user = User.find(session[:user_id])
  end

  def user_authenticated?(param_id)
    param_id.to_s == session[:user_id].to_s ? true : false
  end
end
