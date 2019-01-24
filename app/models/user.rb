class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true

  has_many :user_teams
  has_many :teams, through: :user_teams
  has_many :user_technologies
  has_many :technologies, through: :user_technologies
end
