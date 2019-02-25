class CommentsController < ApplicationController
  before_action :require_login
  before_action :set_user
  before_action :set_team

  def index
    @comments = Comment.where(team_id: @team.id)
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.team_id = @team.id
    @comment.user_id = @user.id

    if @comment.valid?
      @comment.save
      render json: @comment, status: 201
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :team_id)
  end

  def set_user
    @user = User.find(session[:user_id])
  end

  def set_team
    @team = Team.find(params[:team_id])
  end
end
