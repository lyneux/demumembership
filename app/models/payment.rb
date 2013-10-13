class Payment < ActiveRecord::Base
	belongs_to :payable, polymorphic: true
	belongs_to :payment_type
	belongs_to :payment_status

	validates :payment_date, presence: true
	validates :payment_type, presence: true
	validates :payment_status, presence: true
	validates :amount_in_pence, presence: true, numericality: true
end
