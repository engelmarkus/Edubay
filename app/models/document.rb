class Document < ActiveRecord::Base
  belongs_to :doc_type
  belongs_to :lecture
  belongs_to :uploader
  
  validates_presence_of :description, :lecture_date, :doc_type_id, :lecture_id, :uploader_id
end
