class AddMemberToContactDetails < ActiveRecord::Migration
  def change
    add_reference :contact_details, :member, index: true
  end
end
