class Team < ApplicationRecord
  validates :name, presence: true
  validates :creator_id, presence: true
  has_many :user_teams
  has_many :users, through: :user_teams
  has_many :comments
  has_many :team_technologies
  has_many :technologies, through: :team_technologies

  def self.most_comments
    highest_comments = 0
    team = nil
    Team.all.each do |t|
      if t.comments.count > highest_comments
        highest_comments = t.comments.count
        team = t
      end
    end
    return team
  end
end