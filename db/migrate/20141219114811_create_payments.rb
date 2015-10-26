class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
	  t.string :transaction_number , :limit => 45 , :null => false
	  t.string :amount , :limit => 45 , :null => false
	  t.string :currency , :limit => 45 , :null => false
	  t.string :iban , :limit => 34 , :null => false
	  t.string :bic , :limit => 11 , :null => false
	  t.string :txt_reference , :limit => 140 
	  t.integer :status_id , :limit => 11 , :null => false
	  t.integer :account_id , :limit => 11 , :null => false
	  t.string :txt_rejected_reference , :limit => 140 
      t.timestamps
    end
  end
  
  
  def self.down
    drop_table :payments
  end
  
  
end
