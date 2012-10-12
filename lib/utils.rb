# coding: utf-8

module Utils
  # Erzeugt aus einem String einen gültigen Dateinamen.
  # Dabei werden Leerzeichen am Anfang / Ende entfernt und alle nicht-alphanumerischen Zeichen,
  # Punkte und Bindestriche durch Unterstriche ersetzt.
  def sanitize_filename(filename)
    filename.to_s.strip.tap do |name|
      name.gsub!(/[^\w\.\-]/, '_')
    end
  end
  module_function :sanitize_filename
end
