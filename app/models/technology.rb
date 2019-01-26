class Technology < ApplicationRecord
  has_many :user_technologies
  has_many :users, through: :user_technologies
  has_many :team_technologies
  has_many :teams, through: :team_technologies

  def self.find_or_create_by(name)
    @technology = find_by(name: name.capitalize)
    if @technology.nil?
      @technology = self.create(name: name.capitalize)
    else
      @technology
    end
  end
end
