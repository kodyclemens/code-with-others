class Technology < ApplicationRecord
  has_many :user_technologies
  has_many :users, through: :user_technologies
  has_many :team_technologies
  has_many :teams, through: :team_technologies
end
