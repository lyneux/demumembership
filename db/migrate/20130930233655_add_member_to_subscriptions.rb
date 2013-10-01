class AddMemberToSubscriptions < ActiveRecord::Migration
  def change
  	add_reference :subscriptions, :member, index: true
  end
end
