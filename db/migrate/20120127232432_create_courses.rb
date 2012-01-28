class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.string :abbreviation, null: false
      t.references :term, null: false
      t.references :lecturer, null: false
      t.integer :lock_version

      t.timestamps
    end
    
    add_index :courses, :term_id
    add_index :courses, :lecturer_id
    
    add_foreign_key :courses, :terms, dependent: :destroy
    add_foreign_key :courses, :lecturers, dependent: :destroy
  end
end
