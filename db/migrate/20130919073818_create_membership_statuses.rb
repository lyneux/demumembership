class CreateMembershipStatuses < ActiveRecord::Migration
  def change
    create_table :membership_statuses do |t|
      t.string :status

      t.timestamps
    end
  end
end
