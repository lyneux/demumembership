class Payment < ActiveRecord::Base
	belongs_to :payable, polymorphic: true
	belongs_to :payment_type
	belongs_to :payment_status
	belongs_to :member

	validates :member_id, presence: true
	validates :payment_date, presence: true
	validates :payment_type, presence: true
	validates :payment_status, presence: true
	validates :amount_in_pence, presence: true, numericality: true

	def paid
		self.payment_status = PaymentStatus.find_by_description('complete')
		self.save
	end

	def failed
		self.payment_status = PaymentStatus.find_by_description('failed')
		self.save
	end

	def refunded
		self.payment_status = PaymentStatus.find_by_description('refunded')
		self.save
	end

	def chargedback
		self.payment_status = PaymentStatus.find_by_description('chargedback')
		self.save
	end

	def retried
		self.payment_status = PaymentStatus.find_by_description('pending')
		self.save
	end

end
