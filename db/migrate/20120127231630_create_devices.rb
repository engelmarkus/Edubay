class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :name, null: false
      t.references :dev_type, null: false
      t.integer :lock_version

      t.timestamps
    end
    
    add_index :devices, :dev_type_id
    
    add_foreign_key :devices, :dev_types, dependent: :destroy
  end
end
