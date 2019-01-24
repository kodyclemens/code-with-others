class SessionsController < ApplicationController
  def new

  end

  def create
    if params[:session]
      user = User.new(session_params)
      if user.save
        session[:user_id] = user.id
        redirect_to root_path
      else
        flash[:errors] = user.errors.full_messages
        render "users/new"
      end
    else
      @user = User.find_by(username: params[:username])
      if @user.nil?
        redirect_to login_path
      else
        if @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect_to root_path
        else
          redirect_to login_path
        end
      end
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:username, :real_name, :email, :password, :password_confirmation, :github_uid, :github_profile_url, :company, :bio, :avatar_url, :communication_method)
  end
end
