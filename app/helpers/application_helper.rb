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
  
  def show_contact_info(contact_info)
    if contact_info.link.empty?
      if contact_info.vcard_field.nil? or contact_info.vcard_field.empty?
        return h(contact_info.value)
      else
        if contact_info.vcard_field.split(/\s+/).length == 1
          return "<span class=\"#{ contact_info.vcard_field }\">#{ h contact_info.value }</span>"
        else
          output = ""
          fields = contact_info.value.split(/\s+/)
          vcard_fields = contact_info.vcard_field.split(/\s+/)
          0.upto fields.length - 1 do |i|
            output << "<span class=\"#{ vcard_fields[i] }\">#{ h fields[i] }</span>\n"
          end
          return output
        end
      end
    else
      return link_to h(contact_info.value), contact_info.link
    end
  end
  
end
