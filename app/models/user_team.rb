class UserTeam < ApplicationRecord
  validates :user_id, presence: true
  validates_uniqueness_of :user_id, scope: :team_id, message: 'You are already in this group!'
  validates :team_id, presence: true

  belongs_to :user
  belongs_to :team
end
