class CreateEntitlementPeriods < ActiveRecord::Migration
  def change
    create_table :entitlement_periods do |t|
      t.references :member, index: true
      t.date :endDate

      t.timestamps
    end
  end
end
