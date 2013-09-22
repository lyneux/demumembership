class AddSourceChannelRefToMember < ActiveRecord::Migration
  def change
  	add_reference :members, :source_channel, index: true
  end
end
