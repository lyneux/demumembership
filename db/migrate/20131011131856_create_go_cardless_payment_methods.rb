class CreateGoCardlessPaymentMethods < ActiveRecord::Migration
  def change
    create_table :go_cardless_payment_methods do |t|
      t.string :go_cardless_reference
      t.references :payment_methodable, polymorphic: true

      t.timestamps
    end
  end
end
