class CreateLecturers < ActiveRecord::Migration
  def change
    create_table :lecturers do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end
end
