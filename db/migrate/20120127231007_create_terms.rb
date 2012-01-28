class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :name, null: false
      t.integer :lock_version

      t.timestamps
    end
  end
end
