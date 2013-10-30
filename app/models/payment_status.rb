class PaymentStatus < ActiveRecord::Base
	has_many :payment

	PENDING = "pending"
	COMPLETE = "complete"
	FAILED = "failed"
	REFUNDED = "refunded"
	CHARGEDBACK = "chargedback"

	ALL_TYPES = [PENDING, COMPLETE, FAILED, REFUNDED, CHARGEDBACK]

	validates_inclusion_of :description, :in => ALL_TYPES

	def to_s
		description
	end
end
