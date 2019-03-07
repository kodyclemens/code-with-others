# frozen_string_literal: true

class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :avatar_url,
             :communication_method, :goals, :creator_id, :created_at, :repo_url
  has_many :users
end
