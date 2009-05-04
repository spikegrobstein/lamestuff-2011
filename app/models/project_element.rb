class ProjectElement < ActiveRecord::Base
  acts_as_list :scope => 'project_id'
  belongs_to :project
  
  has_attachment :content_type => :image, 
      :storage => :s3, 
      :max_size => 500.kilobytes,
      :resize_to => '600x600>',
      #:thumbnails => { :thumb => '100x100>' },
      :path_prefix => 'public/projects/'

  validates_as_attachment
  
  attr_accessor :should_destroy # virtual attribute in admin/events form for removing elements
  
  def should_destroy?
    should_destroy.to_i == 1
  end
end
