class AddTypeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :account_type, :string, default: 'user'
  end
end
