# A document type, for example 'slides'
class DocType < ActiveRecord::Base
  has_many :documents
  validates_presence_of :name
  before_update :rename_uploaded_files
  before_destroy :has_referenced_documents?
  
  # Checks whether any documents with this document type exist 
  def has_referenced_documents?
    return if documents.empty?
    
    false
  end
  
  private
  
  # As the DocType is a part of all filenames, if a DocType is renamed, every file from this DocType
  # has to be renamed as well.
  def rename_uploaded_files
    if name_changed? then
      documents = Document.find_all_by_doc_type_id(self)
      
      documents.each do |doc|
        File.rename(doc.filename, File.join(doc.get_folder(), Utils.sanitize_filename(name + '_' + doc.id.to_s + doc.file_extension)))      
        logger.info "Successfully renamed file due to changed document type name: #{doc.filename} -> #{File.join(doc.get_folder(), Utils.sanitize_filename(name + '_' + doc.id.to_s + doc.file_extension))}"
      end
    end
  end
end