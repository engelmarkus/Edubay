# A lecturer who has many courses per term.
class Lecturer < ActiveRecord::Base
  has_many :courses
  validates_presence_of :name
  before_destroy :has_referenced_courses?
  
  private
  
  # Check whether this lecturer has got any courses.
  def has_referenced_courses?
    return if courses.empty?
    
    false
  end
end
