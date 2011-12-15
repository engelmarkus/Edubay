class Term < ActiveRecord::Base
  has_many :lectures
  
  validates_presence_of :name
end
