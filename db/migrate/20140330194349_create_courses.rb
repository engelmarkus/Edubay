class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.text :courseID
      t.text :courseName
      t.text :code
      t.text :admissionInfo

      t.timestamps
    end
  end
end
