class PaymentType < ActiveRecord::Base
	has_many :payment

	CHEQUE = "cheque"
	PAYPAL = "paypal"
	DIRECT_DEBIT = "direct debit"
	BANK_TRANSFER = "bank transfer"
	CASH = "cash"

	ALL_TYPES = [CHEQUE, PAYPAL, DIRECT_DEBIT, BANK_TRANSFER, CASH]

	validates_inclusion_of :payment_type, :in => ALL_TYPES

	def to_s
		description
	end
end
