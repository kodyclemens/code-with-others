class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :avatar_url
      t.string :repo_url
      t.integer :creator_id
      t.timestamps
    end
  end
end
