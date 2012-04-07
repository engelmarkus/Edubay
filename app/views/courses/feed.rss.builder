xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0" do
  xml.channel do
    xml.title "edubay - TU München"
    xml.description "Unterlagen zur Lehrveranstaltung \"#{@course.name} (#{@course.abbreviation})\""
    xml.link documents_url
    
    for file in @recently_uploaded_files
      xml.item do
        xml.title file.doc_type + " vom " + I18n.l(file.course_date)
        xml.description file.description
        xml.pubDate file.created_at.to_s(:rfc822)
        xml.link document_url(file)
        xml.guid document_url(file)
      end
    end
  end
end