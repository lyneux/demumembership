class AddSignupSourceToMembers < ActiveRecord::Migration
  def change
    add_column :members, :signup_source, :string
  end
end
