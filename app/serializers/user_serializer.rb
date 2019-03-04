class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :avatar_url, :account_type
  has_many :teams
end
