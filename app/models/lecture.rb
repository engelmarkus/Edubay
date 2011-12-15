class Lecture < ActiveRecord::Base
  belongs_to :term
  belongs_to :lecturer
  has_many :documents
    
  validates_presence_of :name, :abbreviation, :term_id, :lecturer_id
end
