class AddColumnsToTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :description, :string
    add_column :teams, :goals, :string
    add_column :teams, :communication_method, :string
  end
end
