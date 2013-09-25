class AddAreaGroupCoordinatorRefToMember < ActiveRecord::Migration
  def change
  	add_reference :members, :area_group_coordinator, index: true
  end
end
