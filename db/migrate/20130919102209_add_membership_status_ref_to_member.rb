class AddMembershipStatusRefToMember < ActiveRecord::Migration
  def change
    add_reference :members, :membership_status, index: true
  end
end
