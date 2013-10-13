class AddPaymentStatusToPayment < ActiveRecord::Migration
  def change
  	add_reference :payments, :payment_status, index: true
  end
end
