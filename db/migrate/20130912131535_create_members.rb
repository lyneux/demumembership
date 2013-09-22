class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :forename
      t.string :surname
      t.string :notes

      t.timestamps
    end
  end
end
