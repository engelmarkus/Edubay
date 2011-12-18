class Document < ActiveRecord::Base
  belongs_to :doc_type
  belongs_to :lecture
  belongs_to :uploader
  validates_presence_of :description, :lecture_date, :doc_type_id, :lecture_id, :uploader_id
  after_create :create_uploaded_files_folder  
  before_update :rename_uploaded_files_folder
  
  def get_folder
    return File.join(lecture.get_folder(), Utils.sanitize_filename(lecture_date.to_s))
  end
  
  private
  
  def create_uploaded_files_folder
    begin
      Dir.mkdir(File.join(lecture.get_folder(), Utils.sanitize_filename(lecture_date.to_s)))
    rescue Errno::EEXIST => e
      #logger.warn '#{e}'
      # das wird öfter passieren, wenn man eine zweite datei zu einem datum hinzufügt!
    end
    
    FileUtils.touch(File.join(lecture.get_folder(), Utils.sanitize_filename(lecture_date.to_s), Utils.sanitize_filename(doc_type.name + '_' + id.to_s)))
  end
  
  def rename_uploaded_files_folder
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
