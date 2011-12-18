class Lecture < ActiveRecord::Base
  belongs_to :term
  belongs_to :lecturer
  has_many :documents    
  validates_presence_of :name, :abbreviation, :term_id, :lecturer_id
  after_create :create_uploaded_files_folder  
  before_update :rename_uploaded_files_folder
  before_destroy :has_referenced_documents?
    
  def get_folder
    return File.join(term.get_folder(), Utils.sanitize_filename(abbreviation))
  end
  
  private
  
  def create_uploaded_files_folder
    begin
      Dir.mkdir(File.join(term.get_folder(), Utils.sanitize_filename(abbreviation)))
    rescue Errno::EEXIST => e
      logger.warn '#{e}'
    end
  end
  
  def rename_uploaded_files_folder
    if abbreviation_changed? then
      File.rename(File.join(term.get_folder(), Utils.sanitize_filename(abbreviation_was)), File.join(term.get_folder(), Utils.sanitize_filename(abbreviation)))
    end
  end
   
  def has_referenced_documents?
    return if documents.empty?
    
    false
  end
end
