require "Utils"

class Term < ActiveRecord::Base
  has_many :lectures
  validates_presence_of :name
  after_create :create_uploaded_files_folder  
  before_update :rename_uploaded_files_folder
  before_destroy :has_referenced_lectures?
  
  def get_folder
    return File.join("uploaded_files", Utils.sanitize_filename(name))
  end
  
  private
  
  def create_uploaded_files_folder
    begin
      Dir.mkdir(File.join("uploaded_files", Utils.sanitize_filename(name)))
    rescue Errno::EEXIST => e
      logger.warn '#{e}'
    end
  end
  
  def rename_uploaded_files_folder
    if name_changed? then
      File.rename(File.join("uploaded_files", Utils.sanitize_filename(name_was)), File.join("uploaded_files", Utils.sanitize_filename(name)))
    end
  end
  
  def has_referenced_lectures?
    return if lectures.empty?
    
    false
  end
end
