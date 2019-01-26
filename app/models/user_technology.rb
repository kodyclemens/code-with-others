class UserTechnology < ApplicationRecord
  default_scope { order(skill_level: :desc) }
  validates :user_id, presence: true
  validates :technology_id, presence: true
  belongs_to :user
  belongs_to :technology
end
