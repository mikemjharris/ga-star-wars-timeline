class AddProviderToUser < ActiveRecord::Migration
  def change
    add_column :users, :facebook_token, :string
    add_column :users, :twitter_token, :string
    add_column :users, :linkedin_token, :string
    add_column :users, :instagram_token, :string
    add_column :users, :google_oauth2_token, :string
    add_column :users, :github_token, :string
  end
end
