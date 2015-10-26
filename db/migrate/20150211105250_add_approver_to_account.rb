class AddApproverToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :approver_id, :string, :limit => 20, :null => false, :default => '1'
  end
end
