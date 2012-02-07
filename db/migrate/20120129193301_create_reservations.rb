class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.datetime :time_from, null: false
      t.datetime :time_to, null: false
      t.references :device, null: false
      t.integer :lock_version

      t.timestamps
    end
    
    add_index :reservations, :device_id
    
    add_foreign_key :reservations, :devices, :dependent => :destroy
  end
end
