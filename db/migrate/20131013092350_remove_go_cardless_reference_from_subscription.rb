class RemoveGoCardlessReferenceFromSubscription < ActiveRecord::Migration
  def change
    remove_column :subscriptions, :go_cardless_reference, :string
  end
end
