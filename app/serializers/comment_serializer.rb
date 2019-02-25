class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :team_id
  belongs_to :user
  belongs_to :team
end
