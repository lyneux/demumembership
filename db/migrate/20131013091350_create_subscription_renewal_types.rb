class CreateSubscriptionRenewalTypes < ActiveRecord::Migration
  def change
    create_table :subscription_renewal_types do |t|
    	t.string :description
      	t.timestamps
    end
  end
end
