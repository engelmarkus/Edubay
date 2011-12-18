module Utils
  def sanitize_filename(filename)
    filename.strip.tap do |name|
      # Replace all non alphanumeric, underscore
      # or periods with underscore
      name.gsub! /[^\w\.\-]/, '_'
    end
  end
  module_function :sanitize_filename
end
