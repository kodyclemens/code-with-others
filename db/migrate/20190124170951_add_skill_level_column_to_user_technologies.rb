class AddSkillLevelColumnToUserTechnologies < ActiveRecord::Migration[5.2]
  def change
    add_column :user_technologies, :skill_level, :integer
  end
end
