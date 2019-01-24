class CreateTeamTechnologies < ActiveRecord::Migration[5.2]
  def change
    create_table :team_technologies do |t|
      t.integer :team_id
      t.integer :technology_id
      t.timestamps
    end
  end
end
