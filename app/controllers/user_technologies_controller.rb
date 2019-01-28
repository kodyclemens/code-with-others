class UserTechnologiesController < ApplicationController
  before_action :require_login
  before_action :set_user

  def new
    @technology = UserTechnology.new
  end

  def create
    if params[:user_technology][:technology_attributes][:name].empty? && params[:user_technology][:technology_id].empty?
      flash[:error] = 'You must select or create a technology.'
      redirect_to user_technologies_path
    else
      UserTechnology.create(user_technology_params)
      redirect_to user_path(@user)
    end
  end

  def destroy
    technology = UserTechnology.find(params[:technology_id])
    if technology.user_id == session[:user_id]
      technology.destroy
      redirect_to user_path(@user)
    else
      flash[:error] = 'Permission denied'
      redirect_to root_path
    end
  end

  private

  def user_technology_params
    params.require(:user_technology).permit(:technology_id, :skill_level, :user_id, :technology_attributes => [:name])
  end

  def set_user
    @user = User.find(session[:user_id])
  end
end
