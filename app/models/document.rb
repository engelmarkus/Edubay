class Document < ActiveRecord::Base
  belongs_to :doc_type
  belongs_to :lecture
  belongs_to :uploader
  validates_presence_of :description, :lecture_date, :doc_type_id, :lecture_id, :uploader_id
  after_create :create_uploaded_files_folder  
  before_update :rename_uploaded_files_folder
  
  attr_reader :filename
  def filename
    File.join(get_folder(), Utils.sanitize_filename(doc_type.name + '_' + id.to_s + file_extension))
  end  
  
  def get_folder
    return File.join(lecture.get_folder(), Utils.sanitize_filename(lecture_date.to_s))
  end

  def store_file_on_create(file)
    FileUtils.mv(file.tempfile.path, filename)
    FileUtils.chmod(0644, filename)
  end
  
  private
  
  def create_uploaded_files_folder
    begin
      Dir.mkdir(get_folder())
    rescue Errno::EEXIST => e
      #logger.warn '#{e}'
      # das wird öfter passieren, wenn man eine zweite datei zu einem datum hinzufügt!
    end
  end
  
  def rename_uploaded_files_folder
  
  # was kann denn passieren? es kann nur ein update ausgelöst werden, wenn die datei und der komplette pfad schon existiert.
  # welche eigenschaften des dokuments können sich ändern?
  # das datum, der dateityp, nicht die id oder extension!
  # 
  
    if lecture_date_changed? || doc_type_id_changed? then
      #File.rename(File.join(lecture.get_folder(), Utils.sanitize_filename(lecture_date_was.to_s)), File.join(lecture.get_folder(), Utils.sanitize_filename(lecture_date.to_s)))
      # nicht den ordner umbenennen, sondern viel mehr die datei verschieben !
      begin
        Dir.mkdir(File.join(lecture.get_folder(), Utils.sanitize_filename(lecture_date.to_s)))
      rescue Errno::EEXIST => e
      end
      
      doc_type = DocType.find_by_id(doc_type_id)
      doc_type_was = DocType.find_by_id(doc_type_id_was)
      
      FileUtils.mv(File.join(lecture.get_folder(), Utils.sanitize_filename(lecture_date_was.to_s), Utils.sanitize_filename(doc_type_was.name + '_' +  id.to_s)), File.join(lecture.get_folder(), Utils.sanitize_filename(lecture_date.to_s), Utils.sanitize_filename(doc_type.name + '_' + id.to_s)))
      
      logger.info File.join(lecture.get_folder(), Utils.sanitize_filename(lecture_date_was.to_s), Utils.sanitize_filename(doc_type_was.name + '_' +  id.to_s))
      logger.info File.join(lecture.get_folder(), Utils.sanitize_filename(lecture_date.to_s), Utils.sanitize_filename(doc_type.name + '_' + id.to_s))
      
      # das kümmert sich auch noch drum, wenn sich der doc_type ändert!
    end
  end
  
  def delete_file
  end
end
