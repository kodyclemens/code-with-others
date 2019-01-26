class TeamTechnologiesController < ApplicationController
  before_action :require_login
  before_action :set_user
  before_action :set_team

  def new
    redirect_to root_path unless user_is_creator?(@team)
    @technology = TeamTechnology.new
  end
  
  def create
    if !params[:team_technology][:technology].empty?
      technology = Technology.find(params[:team_technology][:technology])
      TeamTechnology.create(team_id: @team.id, technology_id: technology.id)
      redirect_to team_path(@team)
    elsif !params[:team_technology][:technologies][:name].empty?
      technology = Technology.find_or_create_by(params[:team_technology][:technologies][:name])
      TeamTechnology.create(team_id: @team.id, technology_id: technology.id)
      redirect_to team_path(@team)
    else
      flash[:error] = 'You must select or create a technology.'
      redirect_to team_technologies_path
    end
  end
  
  def destroy
    if user_is_creator?(@team)
      technology = TeamTechnology.where(team_id: @team.id, technology_id: params[:technology_id])
      technology.each { |t| t.destroy }
    end
    redirect_to team_path(@team)
  end

  private

  def team_technology_params
    params.require(:team_technology).permit(:technology, technologies:[:name])
  end

  def set_user
    @user = User.find(session[:user_id])
  end

  def set_team
    @team = Team.find(params[:id])
  end

  def user_is_creator?(team)
    team.creator_id.to_s == session[:user_id].to_s ? true : false
  end
end
