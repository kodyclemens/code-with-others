class UserTeamsController < ApplicationController

  def create
    @userteam = UserTeam.new(user_id: params[:user_id], team_id: params[:team_id])
    if @userteam.valid?
      @userteam.save
    else
      flash[:error] = "Something went wrong.."
    end
    redirect_to team_path(@userteam.team_id)
  end

  def destroy
  end
end
