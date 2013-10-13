class Payment < ActiveRecord::Base
	belongs_to :payable, polymorphic: true
	belongs_to :payment_type

	validates :payment_date, presence: true
	validates :payment_type, presence: true
	validates :amount_in_pence, presence: true, numericality: true
end
