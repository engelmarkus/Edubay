class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references :course
      t.string :description
      t.date :date
      t.string :user_id
      t.string :extension

      t.timestamps
    end
    
    add_index :documents, :course_id
  end
end
