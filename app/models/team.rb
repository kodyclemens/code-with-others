class Team < ApplicationRecord
  has_many :user_teams
  has_many :users, through: :user_teams
  has_many :comments
  has_many :team_technologies
  has_many :technologies, through: :team_technologies
  validates :name, presence: true
  validates :creator_id, presence: true
end
