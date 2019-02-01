class UserTechnology < ApplicationRecord
  default_scope { order(skill_level: :desc) }
  validates :user_id, presence: true
  belongs_to :user
  belongs_to :technology, optional: true
  accepts_nested_attributes_for :technology, reject_if: :all_blank

  def self.exists?(name = nil, id = nil, user)
    if id.empty?
      technology = Technology.find_by(name: name.capitalize)
    else
      technology = Technology.find(id)
    end
    return false if technology.nil?

    UserTechnology.where(user_id: user.id, technology_id: technology.id).empty? ? false : true
  end

  def technology_attributes=(technology_attributes)
    technology_attributes.values.each do |v|
      technology = Technology.find_or_create_by(v.capitalize)
      self.technology_id = technology.id
      self.user_id = user.id
      self.save
    end
  end
end
