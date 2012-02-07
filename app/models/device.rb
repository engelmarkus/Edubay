class Device < ActiveRecord::Base
  belongs_to :dev_type
  has_many :reservations
  validates_presence_of :name, :dev_type_id
end
