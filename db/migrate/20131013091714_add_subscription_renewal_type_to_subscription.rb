class AddSubscriptionRenewalTypeToSubscription < ActiveRecord::Migration
  def change
  	add_reference :subscriptions, :subscription_renewal_type, index: true
  end
end
