class AddProviderToUser2 < ActiveRecord::Migration
  def change
    remove_column :users, :facebook_token
    remove_column :users, :twitter_token
    remove_column :users, :linkedin_token
    remove_column :users, :instagram_token
    remove_column :users, :google_oauth2_token
    remove_column :users, :github_token
    add_column :users, :facebook_token, :string
    add_column :users, :twitter_token, :string
    add_column :users, :linkedin_token, :string
    add_column :users, :instagram_token, :string
    add_column :users, :google_oauth2_token, :string
    add_column :users, :github_token, :string
  end
end
