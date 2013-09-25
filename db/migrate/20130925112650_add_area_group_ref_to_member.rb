class AddAreaGroupRefToMember < ActiveRecord::Migration
  def change
  	add_reference :members, :area_group, index: true
  end
end
