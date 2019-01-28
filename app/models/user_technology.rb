class UserTechnology < ApplicationRecord
  default_scope { order(skill_level: :desc) }
  validates :user_id, presence: true
  belongs_to :user
  belongs_to :technology, optional: true
  accepts_nested_attributes_for :technology, reject_if: :all_blank
end
