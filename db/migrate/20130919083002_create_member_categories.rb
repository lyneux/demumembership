class CreateMemberCategories < ActiveRecord::Migration
  def change
    create_table :member_categories do |t|
      t.string :description
      t.integer :price_in_pence_per_year

      t.timestamps
    end
  end
end
