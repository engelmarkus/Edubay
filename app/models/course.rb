class Course < ActiveRecord::Base
  belongs_to :term
  belongs_to :lecturer
  belongs_to :course_type
  has_many :documents

  validates_presence_of :name, :abbreviation, :term_id, :lecturer_id
  after_create :create_uploaded_files_folder  
  before_update :rename_uploaded_files_folder
  before_destroy :has_referenced_documents?
    
  def get_folder
    return File.join(term.get_folder(), Utils.sanitize_filename(abbreviation))
  end
  
  def has_referenced_documents?
    return if documents.empty?
    
    false
  end
  
  private
  
  def create_uploaded_files_folder
    begin
      Dir.mkdir(get_folder())
    rescue Errno::EEXIST => e
      logger.warn '#{e}'
    end
  end
  
  def rename_uploaded_files_folder
    if abbreviation_changed? then
      File.rename(File.join(term.get_folder(), Utils.sanitize_filename(abbreviation_was)), get_folder())
    end
  end
end
