class GoCardlessPaymentMethod < ActiveRecord::Base
	belongs_to :payment_methodable, polymorphic: true
end
