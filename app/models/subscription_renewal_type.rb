class SubscriptionRenewalType < ActiveRecord::Base
	has_many :SubscriptionRenewalType

	MANUAL = "manual"
	DIRECT_DEBIT = "direct debit"

	ALL_TYPES = [MANUAL, DIRECT_DEBIT]

	validates_inclusion_of :description, :in => ALL_TYPES

	def to_s
		description
	end
end
