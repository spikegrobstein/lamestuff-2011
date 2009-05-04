class Category < ActiveRecord::Base
  has_many :project_categories, :dependent => :destroy
  has_many :projects, :through => :project_categories, :order => :position
  
  validates_presence_of :name
  
  before_save :create_url_path
  
  def create_url_path
	  self.url_path = name.downcase.gsub /\s/, '-'
	end
end
