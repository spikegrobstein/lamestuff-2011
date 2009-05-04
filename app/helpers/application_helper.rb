# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def add_project_element_link(link_text)
    link_to_function link_text do |page|
			page.insert_html :bottom, :elements, :partial => 'element', :object => ProjectElement.new
		end
  end
  
  def add_category_link(link_text)
    link_to_function link_text do |page|
      page.insert_html :bottom, :categories, :partial => 'category', :object => ProjectCategory.new
    end
  end
  
end
