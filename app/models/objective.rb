class Objective < ActiveRecord::Base
  acts_as_list
  
  validates_presence_of :description
end
