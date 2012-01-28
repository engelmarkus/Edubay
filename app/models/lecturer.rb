class Lecturer < ActiveRecord::Base
  has_many :courses
  validates_presence_of :name
  before_destroy :has_referenced_courses?
  
  private
  
  def has_referenced_courses?
    return if courses.empty?
    
    false
  end
end
