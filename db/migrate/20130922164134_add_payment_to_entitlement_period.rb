class AddPaymentToEntitlementPeriod < ActiveRecord::Migration
  def change
    add_reference :entitlement_periods, :payment, index: true
  end
end
