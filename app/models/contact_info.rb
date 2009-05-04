class ContactInfo < ActiveRecord::Base
  acts_as_list
  
  validates_presence_of :key
  validates_uniqueness_of :key
  
  validates_presence_of :value
	
	def to_s
		value
	end
  
end
