class ChangeNotesFormatInTableMembers < ActiveRecord::Migration
  def self.up
    change_column :members, :notes, :string, :limit => 10000
  end
  def self.up
    change_column :members, :notes, :string
  end
end
