class TeamTechnology < ApplicationRecord
  belongs_to :team
  belongs_to :technology, optional: true
  accepts_nested_attributes_for :technology, reject_if: :all_blank

  def self.exists?(name = nil, id = nil, team)
    if id.empty?
      technology = Technology.find_by(name: name.capitalize)
    else
      technology = Technology.find(id)
    end
    return false if technology.nil?

    TeamTechnology.where(team_id: team.id, technology_id: technology.id).empty? ? false : true
  end

  def technology_attributes=(technology_attributes)
    technology_attributes.values.each do |v|
      technology = Technology.find_or_create_by(v.capitalize)
      self.technology_id = technology.id
      self.team_id = team.id
      self.save
    end
  end
end
