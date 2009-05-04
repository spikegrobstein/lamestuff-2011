class Experience < ActiveRecord::Base
  acts_as_list
  
  validates_presence_of :description
  validates_presence_of :place
end
