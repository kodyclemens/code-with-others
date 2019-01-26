module UserTechnologiesHelper
  def grab_technology_name(technology_id)
    technology = Technology.find(technology_id)
    technology.name
  end
end
