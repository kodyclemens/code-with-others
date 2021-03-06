class TeamsController < ApplicationController
  before_action :require_login
  before_action :set_user

  def index
    @teams = Team.all
    @team = Team.new
    respond_to do |f|
      f.html { render :index }
      f.json { render json: @teams, status: 200 }
    end
  end

  def show
    @team = Team.find(params[:id])
    @comments = team_comments
    @comment = Comment.new
  end

  def edit
    @team = Team.find(params[:id])
    unless creator_id_match_user?(@team.creator_id)
      flash[:error] = 'Only the creator can edit this team!'
      redirect_to teams_path
    end
  end

  def update
    @team = Team.find(params[:id])
    if !creator_id_match_user?(@team.creator_id)
      flash[:error] = 'Only the creator can edit this team!'
      redirect_to teams_path
    elsif creator_id_match_user?(params[:team][:creator_id])
      params[:team][:avatar_url] = 'https://i.imgur.com/v3Avup2.png' if params[:team][:avatar_url].empty?
      @team.update(team_params)
      redirect_to team_path(@team)
    else
      flash[:error] = 'Something went wrong!'
      redirect_to teams_path
    end
  end

  def create
    @team = Team.new(team_params)
    if @team.valid? && creator_id_match_user?(params[:team][:creator_id])
      @team.avatar_url = 'https://i.imgur.com/v3Avup2.png' if @team.avatar_url.empty?
      @team.save
      UserTeam.create(team_id: @team.id, user_id: @user.id)
      redirect_to teams_path
    else
      flash[:error] = 'Unsuccessfully created, please try again.'
      redirect_to new_team_path
    end
  end

  def most_comments
    @team = Team.most_comments
  end

  private

  def set_user
    @user = User.find(session[:user_id])
  end

  def team_params
    params.require(:team).permit(:name, :avatar_url, :repo_url, :creator_id, :description, :goals, :communication_method)
  end

  def creator_id_match_user?(team_creator_id)
    team_creator_id.to_s == session[:user_id].to_s
  end

  def team_comments
    Comment.where(team_id: @team.id)
  end
end
