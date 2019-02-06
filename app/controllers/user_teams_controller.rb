class UserTeamsController < ApplicationController
  before_action :require_login
  before_action :set_user

  def create
    # Prevent form editing to ensure users cannot be added by editing the form
    @userteam = UserTeam.new(user_id: params[:user_id], team_id: params[:team_id])
    if @userteam.valid?
      @userteam.save
    else
      flash[:error] = 'Something went wrong..'
    end
    redirect_to team_path(@userteam.team_id)
  end

  def destroy
    # Ensure @team and @team_member are valid objects, handle errors
    @team = Team.find(params[:id])
    @team_member = User.find(params[:user_id])
    if user_authenticated?(@user.id) && @team.users.include?(@team_member)
      userteam = UserTeam.where(user_id: params[:user_id], team_id: @team.id)
      userteam.each(&:destroy)
    else
      flash[:error] = 'Something went wrong..'
    end
    redirect_to team_path(@team)
  end

  private

  def set_user
    @user = User.find(session[:user_id])
  end

  def user_authenticated?(user_id)
    user_id.to_s == @team_member.id.to_s || @user.id.to_s == @team.creator_id.to_s ? true : false
  end
end
