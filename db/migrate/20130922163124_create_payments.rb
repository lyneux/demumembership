class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.date :payment_date
      t.integer :amount_in_pence
      t.references :payable, polymorphic: true

      t.timestamps
    end
  end
end
