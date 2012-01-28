class CreateDevTypes < ActiveRecord::Migration
  def change
    create_table :dev_types do |t|
      t.string :name, null: false
      t.integer :lock_version

      t.timestamps
    end
  end
end
