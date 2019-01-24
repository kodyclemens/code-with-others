class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(session_params)
    if user.save
      session[:user_id] = user.id
    else
      flash[:errors] = user.errors.full_messages
      render 'users/new'
    end
  end

  private

  def session_params
    params.require(:session).permit(:username, :password, :password_confirmation)
  end
end
