class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :id
      t.boolean :visible_to_all

      t.timestamps
    end
    
    add_index :courses, :id, unique: true
  end
end
