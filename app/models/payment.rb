class Payment < ActiveRecord::Base
	belongs_to :payable, polymorphic: true

	validates :payment_date, presence: true
	validates :amount_in_pence, presence: true, numericality: true
end
