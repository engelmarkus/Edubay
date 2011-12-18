class Lecturer < ActiveRecord::Base
  has_many :lectures
  validates_presence_of :name
  before_destroy :has_referenced_lectures?
  
  private
  
  def has_referenced_lectures?
    return if lectures.empty?
    
    false
  end
end
