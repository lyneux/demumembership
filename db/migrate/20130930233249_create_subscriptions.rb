class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :go_cardless_reference

      t.timestamps
    end
  end
end
