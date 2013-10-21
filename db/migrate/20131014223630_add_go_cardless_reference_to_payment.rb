class AddGoCardlessReferenceToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :go_cardless_reference, :string
  end
end
