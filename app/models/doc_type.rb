class DocType < ActiveRecord::Base
  has_many :documents
  validates_presence_of :name
  before_update :rename_uploaded_files
  before_destroy :has_referenced_documents?
  
  def has_referenced_documents?
    return if documents.empty?
    
    false
  end
  
  private
  
  def rename_uploaded_files
    # es müssen hier alle dateien umbenannt werden, weil der name des doc_types teil des dateinamens ist!
    if name_changed? then
      documents = Document.find_all_by_doc_type_id(self)
      
      documents.each do |doc|
        File.rename(doc.filename, File.join(doc.get_folder(), Utils.sanitize_filename(name + '_' + doc.id.to_s + doc.file_extension)))      
      end
    end
  end
end