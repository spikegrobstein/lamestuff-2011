class Project < ActiveRecord::Base
  acts_as_list
  
  has_many :elements, :class_name => 'ProjectElement', :order => 'position', :dependent => :destroy
  has_many :project_categories, :dependent => :destroy
  has_many :categories, :through => :project_categories, :order => 'name'
  
  validates_presence_of :title
  validates_uniqueness_of :title
  
  validates_associated :elements
  
  has_attachment :content_type => :image, 
      :storage => :s3, 
      :max_size => 500.kilobytes,
      :resize_to => '125x125>',
      #:thumbnails => { :thumb => '100x100>' },
      :path_prefix => 'public/portfolio/'

  validates_as_attachment
  
  after_update :save_associated
  before_save :create_url_path
	
	def element_attributes=(element_attributes)
	  element_attributes.each do |attrib|
	    if attrib[:id].blank?
	      elements.build(attrib)
	    else
	      element = elements.detect { |e| e.id == attrib[:id].to_i }
	      element.attributes = attrib
	    end
	  end
	end
	
	def category_attributes=(category_attributes)
	  category_attributes.each do |attributes|
	    if attributes[:id].blank?
	      p = project_categories.build
	      p.category_id = attributes[:category_id]
	    else
	      category = project_categories.detect { |c| c.id == attributes[:id].to_i }
	      category.attributes = attributes
	    end
	  end
	end
	
	
	def save_associated
	  elements.each do |e|
	    if e.should_destroy?
	      e.destroy
	    else
	      e.save(false)
	    end
	  end
	  
	  project_categories.each do |c|
	    if c.should_destroy?
	      c.destroy
	    else
	      c.save(false)
	    end
	  end
	end
	
	def create_url_path
	  self.url_path = title.downcase.gsub /\s/, '-'
	end
  
end
