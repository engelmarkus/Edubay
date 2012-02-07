# A course belonging to a lecturer and containing many documents.
class Course < ActiveRecord::Base
  belongs_to :term
  belongs_to :lecturer
  belongs_to :course_type
  has_many :documents

  validates_presence_of :name, :abbreviation, :term_id, :lecturer_id
  after_create :create_uploaded_files_folder  
  before_update :rename_uploaded_files_folder
  before_destroy :has_referenced_documents?
  
  # Retrieves the folder containing all the files belonging to this course.
  def get_folder
    return File.join(term.get_folder(), Utils.sanitize_filename(abbreviation))
  end
  
  # Checks whether any documents belong to this course.
  def has_referenced_documents?
    return if documents.empty?
    
    false
  end
  
  private
  
  # Creates a folder for storing all the files associated with this course.
  # Automatically executed on course creation.
  def create_uploaded_files_folder
    begin
      Dir.mkdir(get_folder())
      logger.info "Successfully created folder for course: #{get_folder()}"
    rescue Errno::EEXIST => e
      #logger.warn '#{e}'
    end
  end
  
  # As the course abbreviation is the name of the folder containing the associated files as well,
  # the folder has to be renamed on changing the course abbreviation.
  def rename_uploaded_files_folder
    if abbreviation_changed? then
      File.rename(File.join(term.get_folder(), Utils.sanitize_filename(abbreviation_was)), get_folder())
      logger.info "Successfully renamed folder due to changed course abbreviation: #{File.join(term.get_folder(), Utils.sanitize_filename(abbreviation_was))} -> #{get_folder()}"
    end
  end
end
