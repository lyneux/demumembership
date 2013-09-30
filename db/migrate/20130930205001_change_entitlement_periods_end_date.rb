class ChangeEntitlementPeriodsEndDate < ActiveRecord::Migration
  def change
  	change_table :entitlement_periods do |t|
  		t.rename :endDate, :end_date
  	end
  end
end
