class ProjectCategory < ActiveRecord::Base
  belongs_to :category
  belongs_to :project
  
  attr_accessor :should_destroy # virtual attribute in admin/events form for removing category
  
  def should_destroy?
    should_destroy.to_i == 1
  end
end
