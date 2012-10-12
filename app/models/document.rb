class Document < ActiveRecord::Base
  belongs_to :course
  attr_accessible :date, :description, :extension, :user_id, :course_id
  
  after_destroy :delete_uploaded_file
  
  # ########################
  # Methoden zum Management der zugehörigen hochgeladenen Datei
  # ########################
  
  # Der vollständige Pfad der zum Dokument gehörigen Datei.
  def filename
    File.join(course.folder, date.to_s + "_" + id.to_s + extension)
  end
  
  # Speichert die hochgeladene Datei ab.
  # Wird direkt vom Controller aufgerufen.
  def store_uploaded_file(file)
    FileUtils.mv(file.tempfile.path, filename)
    logger.info "Successfully moved file due to document creation: #{file.tempfile.path} -> #{filename}"
    
    FileUtils.chmod(0644, filename)
    logger.info "Successfully changed file permissions due to document creation: #{filename} -> 0644"
  end
  
  # Löscht die Datei beim Zerstören des Datensatzes.
  def delete_uploaded_file
    File.delete(filename)
    logger.info "Successfully deleted file #{filename} due to document destruction."
  end
end
