class Comment < ApplicationRecord
  default_scope { order(updated_at: :desc) }
  validates :content, presence: true, length: { minimum: 2}
  validates :user_id, presence: true
  validates :team_id, presence: true
  belongs_to :team
  belongs_to :user
end
