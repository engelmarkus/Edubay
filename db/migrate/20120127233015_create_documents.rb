class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :description, null: false
      t.date :course_date, null: false
      t.string :file_extension
      t.references :doc_type, null: false
      t.references :course, null: false
      t.integer :lock_version

      t.timestamps
    end
    
    add_index :documents, :doc_type_id
    add_index :documents, :course_id
    
    add_foreign_key :documents, :doc_types, dependent: :destroy
    add_foreign_key :documents, :courses, dependent: :destroy
  end
end
