class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :real_name
      t.string :email
      t.string :password_digest
      t.string :github_uid
      t.string :github_profile_url
      t.string :company
      t.string :bio
      t.string :avatar_url
      t.timestamps
    end
  end
end
