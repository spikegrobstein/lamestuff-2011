# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  #layout 'main'
  
  helper :all # include all helpers, all the time
  
  include AuthenticatedSystem
  before_filter :logged_in?, :load_header_contact_info
  
  before_filter :set_controller_and_action_names 

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '994a7fbf5ef4d614222fb07c66473706'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  private
  
  def set_controller_and_action_names 
    @current_controller = controller_name 
    @current_action     = action_name 
  end
	
	def load_header_contact_info
		@header_contact_infos = ContactInfo.find_all_by_show_in_header(true, :order => :position)
	end
  
  def category_list
  	Category.find(:all, :order => :name).collect{|c| [c.name, c.id]}
  end
end
