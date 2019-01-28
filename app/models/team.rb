class Team < ApplicationRecord
  default_scope { order(updated_at: :desc) }
  validates :name, presence: true
  validates :creator_id, presence: true
  has_many :user_teams
  has_many :users, through: :user_teams
  has_many :comments
  has_many :team_technologies
  has_many :technologies, through: :team_technologies

  def self.most_comments
    joins(:comments).group(:id).order('COUNT(comments.id) DESC').limit(1).first
    # SELECT teams.name COUNT(comments.id) AS 'comment_count' JOIN comments ON teams.id = comment.team_id GROUP BY team.name ORDER BY comment_count DESC LIMIT 1
  end
end