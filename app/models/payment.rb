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
end
