class Payment < ActiveRecord::Base
	belongs_to :payable, polymorphic: true
	belongs_to :payment_method

	validates :payment_date, presence: true
	validates :payment_method, presence: true
	validates :amount_in_pence, presence: true, numericality: true
end
