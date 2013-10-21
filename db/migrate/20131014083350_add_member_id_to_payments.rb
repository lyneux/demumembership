class AddMemberIdToPayments < ActiveRecord::Migration
  def change
  	add_column :payments, :member_id , :integer ,:references=>"members", index:true
  	add_index :payments, :member_id
  end
end
