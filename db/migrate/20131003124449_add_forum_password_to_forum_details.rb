class AddForumPasswordToForumDetails < ActiveRecord::Migration
  def change
  	add_column :forum_details, :forum_password, :string
  end
end
