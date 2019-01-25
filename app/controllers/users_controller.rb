class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if params[:session]
      @user = User.new(user_params)
      if @user.valid?
        @user.save
        session[:user_id] = user.id
        redirect_to root_path
      else
        render 'users/new'
      end
    end
  end

  private

  def user_params
    params.require(:session).permit(:username, :real_name, :email, :password, :password_confirmation, :github_uid, :github_profile_url, :company, :bio, :avatar_url, :communication_method)
  end
end
