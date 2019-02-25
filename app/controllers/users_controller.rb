class UsersController < ApplicationController
  before_action :require_login, except: %i[new create]
  before_action :set_user, only: %i[edit update]

  def new
    if session[:user_id].nil?
      @user = User.new
    else
      redirect_to root_path
    end
  end

  def index
    @users = User.all
    respond_to do |f|
      f.html { render :index }
      f.json { render json: @users, status: 200 }
    end
  end

  def show
    if User.exists?(params[:id])
      @user = User.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def edit
    redirect_to root_path unless user_authenticated?(params[:id])
  end

  def update
    if @user.update(user_params) && user_authenticated?(params[:id])
      redirect_to user_path(@user)
    else
      render 'users/edit'
    end
  end

  def link_github
    if @user.github_uid.nil?
      # link
    else
      flash[:error] = 'Your account is already linked!'
      redirect_to user_path(@user)
    end
  end

  def create
    @user = User.new(user_params) if params[:user]
    if verify_recaptcha(model: @user) && @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render 'users/new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :real_name, :email, :password,
                                 :password_confirmation, :github_uid,
                                 :github_profile_url, :company,
                                 :bio, :avatar_url, :communication_method)
  end

  def set_user
    @user = User.find(session[:user_id])
  end

  def user_authenticated?(param_id)
    param_id.to_s == session[:user_id].to_s
  end
end
