require "Utils"

class Term < ActiveRecord::Base
  has_many :courses
  validates_presence_of :name
  after_create :create_uploaded_files_folder  
  before_update :rename_uploaded_files_folder
  before_destroy :has_referenced_courses?
  
  def get_folder
    return File.join("uploaded_files", Utils.sanitize_filename(name))
  end
  
  def has_referenced_courses?
    return if courses.empty?
    
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
    if name_changed? then
      File.rename(File.join("uploaded_files", Utils.sanitize_filename(name_was)), get_folder())
    end
  end
end