class AddUuidToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :uuid, :string, :limit => 36, :null => false, :default => '1'
  end
end
