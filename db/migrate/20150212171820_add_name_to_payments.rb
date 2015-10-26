class AddNameToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :name, :string, :limit => 70
  end
end
