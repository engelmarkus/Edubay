class CreateLecturers < ActiveRecord::Migration
  def change
    create_table :lecturers do |t|
      t.string :name, null: false
      t.integer :lock_version

      t.timestamps
    end
  end
end
