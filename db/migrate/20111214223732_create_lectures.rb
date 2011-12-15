class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.string :name, :null => false
      t.string :abbreviation, :null => false
      t.references :term, :null => false
      t.references :lecturer, :null => false

      t.timestamps
    end
    
    add_index :lectures, :term_id
    add_index :lectures, :lecturer_id
    
    add_foreign_key :lectures, :terms, :dependent => :destroy
    add_foreign_key :lectures, :lecturers, :dependent => :destroy
  end
end
