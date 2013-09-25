class AddDateAddedToMember < ActiveRecord::Migration
  def change
    add_column :members, :date_added, :date
  end
end
