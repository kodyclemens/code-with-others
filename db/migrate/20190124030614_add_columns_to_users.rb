class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :communication_method, :string
  end
end
