class CreateAreaGroups < ActiveRecord::Migration
  def change
    create_table :area_groups do |t|
      t.string :name
      t.string :description
      t.boolean :active

      t.timestamps
    end
  end
end
