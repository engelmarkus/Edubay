class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :description, null: false
      t.date :course_date, null: false
      t.string :file_extension
      t.string :doc_type, null: false
      t.references :course, null: false
      t.integer :lock_version
      t.string :uploader_id, null: false

      t.timestamps
    end
    
    add_index :documents, :course_id
  end
end
