class TeamsController < ApplicationController
  before_action :require_login
  before_action :set_user
  
  def index
    @teams = Team.all
  end
  
  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.valid? && creator_id_match_user?
      @team.save
      redirect_to teams_path
    else
      flash[:error] = 'Unsuccessfully created, please try again.'
      redirect_to new_team_path
    end
  end

  private

  def set_user
    @user = User.find(session[:user_id])
  end

  def team_params
    params.require(:team).permit(:name, :avatar_url, :repo_url, :creator_id)
  end

  def creator_id_match_user?
    params[:team][:creator_id] == session[:user_id].to_s
  end
end
