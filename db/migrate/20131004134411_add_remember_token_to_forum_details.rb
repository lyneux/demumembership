class AddRememberTokenToForumDetails < ActiveRecord::Migration
  def change
    add_column :forum_details, :remember_token, :string
    add_index  :forum_details, :remember_token
  end
end
