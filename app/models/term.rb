require "Utils"

# A term with lots of courses and documents
class Term < ActiveRecord::Base
  has_many :courses
  validates_presence_of :name
  after_create :create_uploaded_files_folder  
  before_update :rename_uploaded_files_folder
  before_destroy :has_referenced_courses?
  
  # The path to the folder containing all data belonging to this term.
  def get_folder
    return File.join("uploaded_files", Utils.sanitize_filename(name))
  end
  
  # Checks whether any courses belong to this term.
  def has_referenced_courses?
    return if courses.empty?
    
    false
    #return !courses.empty?
  end
  
  private
  
  # Creates the data folder for this term.
  def create_uploaded_files_folder
    begin
      Dir.mkdir(get_folder())
      logger.info "Successfully created folder for term: #{get_folder()}"
    rescue Errno::EEXIST => e
      #logger.warn '#{e}'
    end
  end
  
  # Renames the data folder for this term in case the term's name is changed.
  def rename_uploaded_files_folder
    if name_changed? then
      File.rename(File.join("uploaded_files", Utils.sanitize_filename(name_was)), get_folder())
      logger.info "Successfully renamed folder due to changed term name: #{File.join('uploaded_files', Utils.sanitize_filename(name_was))} -> #{get_folder()}"
    end
  end
end