class RemovePaymentIdFromEntitlementPeriod < ActiveRecord::Migration
  def change
  	remove_column :entitlement_periods, :payment_id, :int
  end
end
