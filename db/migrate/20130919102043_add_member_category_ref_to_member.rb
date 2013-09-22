class AddMemberCategoryRefToMember < ActiveRecord::Migration
  def change
    add_reference :members, :member_category, index: true
  end
end
