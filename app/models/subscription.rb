class Subscription < ActiveRecord::Base
	belongs_to :member
	belongs_to :subscription_renewal_type
end
