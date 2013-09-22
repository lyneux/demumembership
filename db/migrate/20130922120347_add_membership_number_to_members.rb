class AddMembershipNumberToMembers < ActiveRecord::Migration
  def change
    add_column :members, :membership_number, :integer, uniqueness: true
  end
end
