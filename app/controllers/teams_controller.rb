class TeamsController < ApplicationController
  before_action :require_login
  before_action :set_user
  
  def index
    @teams = Team.all
  end
  
  def new
    @team = Team.new
  end

  def show
    @team = Team.find(params[:id])
    @comments = team_comments(@team)
  end

  def edit
    @team = Team.find(params[:id])
    if !creator_id_match_user?(@team.creator_id)
      flash[:error] = "Only the creator can edit this team!"
      redirect_to teams_path
    end
  end

  def update
    @team = Team.find(params[:id])
    if !creator_id_match_user?(@team.creator_id)
      flash[:error] = "Only the creator can edit this team!"
      redirect_to teams_path
    elsif creator_id_match_user?(params[:team][:creator_id])
      params[:team][:avatar_url] = 'https://i.imgur.com/v3Avup2.png' if params[:team][:avatar_url].empty?
      @team.update(team_params)
      redirect_to team_path(@team)
    else
      flash[:error] = "Something went wrong!"
      redirect_to teams_path
    end
  end

  def create
    @team = Team.new(team_params)
    if @team.valid? && creator_id_match_user?(params[:team][:creator_id])
      @team.avatar_url = 'https://i.imgur.com/v3Avup2.png' if @team.avatar_url.empty?
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

  def creator_id_match_user?(team_creator_id)
    team_creator_id.to_s == session[:user_id].to_s
  end

  def team_comments(team)
    Comment.where(team_id: @team.id)
  end
end
