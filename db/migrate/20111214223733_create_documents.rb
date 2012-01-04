class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :description, :null => false
      t.date :lecture_date, :null => false
      t.string :file_extension
      t.references :doc_type, :null => false
      t.references :lecture, :null => false
      t.references :uploader, :null => false

      t.timestamps
    end
    
    add_index :documents, :doc_type_id
    add_index :documents, :lecture_id
    add_index :documents, :uploader_id
    
    add_foreign_key :documents, :doc_types, :dependent => :destroy
    add_foreign_key :documents, :lectures, :dependent => :destroy
    #add_foreign_key :documents, :uploaders, :dependent => :destroy
  end
end
