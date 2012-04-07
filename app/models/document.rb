class Document < ActiveRecord::Base
  include Enumerize
  
  enumerize :doc_type, in: [:Pencast, :Slides]
  
  belongs_to :course
  #belongs_to :uploader
  
  validates_presence_of :description, :course_date, :doc_type, :course_id, :uploader_id
  after_create :create_uploaded_files_folder
  before_update :rename_uploaded_files_folder
  
  attr_reader :filename
  # The name of the file belonging to this document.
  def filename
    File.join(get_folder(), Utils.sanitize_filename(doc_type + '_' + id.to_s + file_extension))
  end  
  
  # Retrieves the folder containing this document's associated file.
  def get_folder
    return File.join(course.get_folder(), Utils.sanitize_filename(course_date.to_s))
  end

  # Moves the uploaded file to the correct location on creation.
  def store_file_on_create(file)
    FileUtils.mv(file.tempfile.path, filename)
    logger.info "Successfully moved file due to document creation: #{file.tempfile.path} -> #{filename}"
    
    FileUtils.chmod(0644, filename)
    logger.info "Successfully changed file's permissions due to document creation: #{filename} -> 0644"
  end
  
  private
  
  # Creates a folder containing this document's associated file.
  def create_uploaded_files_folder
    begin
      Dir.mkdir(get_folder())
      logger.info "Successfully created folder due to document creation: #{get_folder()}"
    rescue Errno::EEXIST => e
      # das wird öfter passieren, wenn man eine zweite datei zu einem datum hinzufügt!
      logger.info "Did not create folder when creating document as it already existed: #{get_folder()}"
    end
  end
  
  def rename_uploaded_files_folder
  
  # was kann denn passieren? es kann nur ein update ausgelöst werden, wenn die datei und der komplette pfad schon existiert.
  # welche eigenschaften des dokuments können sich ändern?
  # das datum, der dateityp, nicht die id oder extension!
  # 
  
    if course_date_changed? || doc_type_changed? then
      # nicht den ordner umbenennen, sondern viel mehr die datei verschieben !
      begin
        Dir.mkdir(File.join(course.get_folder(), Utils.sanitize_filename(course_date.to_s)))
        logger.info "Successfully created folder due to changed course date: #{File.join(course.get_folder(), Utils.sanitize_filename(course_date.to_s))}"
      rescue Errno::EEXIST => e
      end
      
      #doc_type = DocType.find_by_id(doc_type_id)
      #doc_type_was = DocType.find_by_id(doc_type_id_was)
      
      FileUtils.mv(File.join(course.get_folder(), Utils.sanitize_filename(course_date_was.to_s), Utils.sanitize_filename(doc_type_was + '_' +  id.to_s)), File.join(course.get_folder(), Utils.sanitize_filename(course_date.to_s), Utils.sanitize_filename(doc_type + '_' + id.to_s)))
      
      logger.info File.join(course.get_folder(), Utils.sanitize_filename(course_date_was.to_s), Utils.sanitize_filename(doc_type_was + '_' +  id.to_s))
      logger.info File.join(course.get_folder(), Utils.sanitize_filename(course_date.to_s), Utils.sanitize_filename(doc_type + '_' + id.to_s))
      
      # das kümmert sich auch noch drum, wenn sich der doc_type ändert!
    end
  end
  
  def delete_file
  end
end
