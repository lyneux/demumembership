class PaymentStatus < ActiveRecord::Base
	has_many :payment

	PENDING = "pending"
	COMPLETE = "complete"

	ALL_TYPES = [PENDING, COMPLETE]

	validates_inclusion_of :description, :in => ALL_TYPES

	def to_s
		description
	end
end
