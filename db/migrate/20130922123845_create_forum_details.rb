class CreateForumDetails < ActiveRecord::Migration
  def change
    create_table :forum_details do |t|
      t.integer :forum_id
      t.string :forum_name

      t.timestamps
    end
  end
end
