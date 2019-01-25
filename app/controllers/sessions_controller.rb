class SessionsController < ApplicationController
  def new

  end

  def create
    if params[:username]
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
    elsif auth
      @user = User.find_by(github_uid: auth[:uid])
      if @user.nil?
        @user = User.create(github_uid: auth[:uid], username: auth[:info][:nickname], email: auth[:info][:email], avatar_url: auth[:info][:image], github_profile_url: auth[:info][:urls][:GitHub], password: SecureRandom.hex, bio: auth[:extra][:raw_info][:bio], company: auth[:extra][:raw_info][:company])
        session[:user_id] = @user.id
        redirect_to root_path
      else
        session[:user_id] = @user.id
        redirect_to root_path
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

  def auth
    request.env['omniauth.auth']
  end
end
