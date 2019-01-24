class User < ApplicationRecord
  validates :username, presence: true
  validates :password, presence: true, confirmation: true

  has_secure_password
  has_many :user_teams
  has_many :teams, through: :user_teams
  has_many :user_technologies
  has_many :technologies, through: :user_technologies
end
