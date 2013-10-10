class AddRoleRefToForumDetails < ActiveRecord::Migration
  def change
  	add_reference :forum_details, :role, index: true
  end
end
