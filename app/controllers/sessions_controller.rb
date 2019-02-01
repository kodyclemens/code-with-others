# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    redirect_to root_path if session[:user_id]
  end

  def create
    if params[:username]
      @user = User.find_by(username: params[:username])
      if @user.nil?
        flash[:error] = 'Did you type everything in correctly?'
        redirect_to login_path
      elsif @user.authenticate(params[:password])
        session[:user_id] = @user.id
        flash[:message] = "Welcome, #{@user.username}"
        redirect_to root_path
      end
    end
  end

  def omniauth
    if auth
      @user = User.find_or_create_by_uid(auth)
      session[:user_id] = @user.id
      flash[:message] = "Welcome, #{@user.username}"
      redirect_to root_path
    else
      flash[:error] = 'Something went wrong...'
      redirect_to login_path
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:username, :real_name, :email, :password,
                                    :password_confirmation, :github_uid, :github_profile_url,
                                    :company, :bio, :avatar_url, :communication_method)
  end

  def auth
    request.env['omniauth.auth']
  end
end
