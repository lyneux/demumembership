class AddMemberRefToAreaGroup < ActiveRecord::Migration
  def change
  	add_column :area_groups, :coordinator_id, :integer
    add_index :area_groups, :coordinator_id

    remove_column :members, :area_group_coordinator_id
  end
end
