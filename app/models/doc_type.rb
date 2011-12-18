class DocType < ActiveRecord::Base
  has_many :documents
  validates_presence_of :name
  before_destroy :has_referenced_documents?
  
  private
  
  def has_referenced_documents?
    return if documents.empty?
    
    false
  end
end
