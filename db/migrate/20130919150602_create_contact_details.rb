class CreateContactDetails < ActiveRecord::Migration
  def change
    create_table :contact_details do |t|
      t.string :address_line_1
      t.string :address_line_2
      t.string :address_line_3
      t.string :town
      t.string :county
      t.string :postcode
      t.string :country
      t.string :telephone
      t.string :email

      t.timestamps
    end
  end
end
