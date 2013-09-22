class PaymentMethod < ActiveRecord::Base
	has_many :payment

	CHEQUE = "cheque"
	PAYPAL = "paypal"
	DIRECT_DEBIT = "direct debit"
	BANK_TRANSFER = "bank transfer"
	CASH = "cash"

	ALL_METHODS = [CHEQUE, PAYPAL, DIRECT_DEBIT, BANK_TRANSFER, CASH]

	validates_inclusion_of :payment_method, :in => ALL_METHODS
end
