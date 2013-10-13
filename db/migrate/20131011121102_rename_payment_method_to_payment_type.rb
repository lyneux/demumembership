class RenamePaymentMethodToPaymentType < ActiveRecord::Migration
	def change

        change_table :payment_methods do |t|
	  		t.rename :payment_method, :description
  		end

        change_table :payments do |t|
	  		t.rename :payment_method_id, :payment_type_id
  		end

  		rename_table :payment_methods, :payment_types
  		
    end
end
