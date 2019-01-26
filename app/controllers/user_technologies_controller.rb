class UserTechnologiesController < ApplicationController
  before_action :require_login
  before_action :set_user

  def new
    @technology = UserTechnology.new
  end
  
  def create
    if !params[:user_technology][:technology].empty?
      technology = Technology.find(params[:user_technology][:technology])
      UserTechnology.create(user_id: @user.id, technology_id: technology.id, skill_level: params[:user_technology][:skill_level])
      redirect_to user_path(@user)
    elsif !params[:user_technology][:technologies][:name].empty?
      technology = Technology.find_or_create_by(params[:user_technology][:technologies][:name])
      UserTechnology.create(user_id: @user.id, technology_id: technology.id, skill_level: params[:user_technology][:skill_level])
      redirect_to user_path(@user)
    else
      flash[:error] = 'You must select or create a technology.'
      redirect_to user_technologies_path
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
    params.require(:user_technology).permit(:technology, :skill_level, technologies:[:name])
  end

  def set_user
    @user = User.find(session[:user_id])
  end
end
