class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string  :account_number , :limit => 20 , :null => false
	  t.string :account_fidor_id , :limit => 20 , :null => false
	  t.string :customer_id , :limit => 20 , :null => false
	  t.boolean :two_man_rule , :null => false , :default=> false
	  t.boolean :is_active , :null => false , :default=> true
      t.timestamps
    end
  end
  
  def self.down
    drop_table :accounts
  end
end
