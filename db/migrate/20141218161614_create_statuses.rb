class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :name
      t.timestamps
    end
  end
  
  def self.down
    drop_table :statuses
  end
  
end
