class AddMemberToForumDetails < ActiveRecord::Migration
  def change
  	add_reference :forum_details, :member, index: true
  end
end
