class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :avatar_url,
  :communication_method, :goals, :creator_id, :created_at
  has_many :users
end
