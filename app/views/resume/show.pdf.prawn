pdf.bounding_box([0, pdf.bounds.height], :width => pdf.bounds.width) do  
  pdf.bounding_box([0, pdf.bounds.height], :width => pdf.bounds.width / 2) do
    pdf.text @resume_contact_infos.shift, :size => 24, :style => :bold
  end

  pdf.bounding_box([pdf.bounds.width / 2, pdf.bounds.height], :width => pdf.bounds.width / 2) do
		@resume_contact_infos.each do |c|
	    pdf.text c, :align => :right
		end
  end
  
end

pdf.stroke_horizontal_rule

# objectives:
pdf.pad_top 10 do
  pdf.text 'Objective', :size => 16, :style => :bold
end

indent(pdf, 10) do
  @objectives.each do |objective|
    pdf.text objective.description
  end
end

# education
pdf.pad_top 10 do
  pdf.text 'Education/Certifications', :size => 16, :style => :bold
end

indent(pdf, 10) do
  @certifications.each do |certification|
    pdf.text certification.description
  end
end

# skills
pdf.pad_top 10 do
	pdf.text "Skills", :size => 16, :style => :bold
end

indent(pdf, 10) do
  @skills.each do |skill|
	  pdf.pad_bottom 5 do
		  pdf.text skill.description
	  end
  end
end

# experience
pdf.pad_top 10 do
	pdf.text "Work Experience", :size => 16, :style => :bold
end

@experiences.each do |experience|
	pdf.pad 5 do
	  indent(pdf, 10) do
		  pdf.text "#{experience.place} - #{experience.location} - #{experience.industry}", :style => :bold
		  start_date = "#{Date::MONTHNAMES[experience.start_date.month]} #{experience.start_date.year}"
		  end_date = "#{Date::MONTHNAMES[experience.end_date.month]} #{experience.end_date.year}"
		  end_date = 'present' if experience.end_date > Date.today
		  pdf.text "#{experience.work_position} (#{start_date} - #{end_date})", :style => :italic
	  end
		indent(pdf, 25) do
		  pdf.text experience.description
	  end
	end
end

# personal projects:
pdf.pad_top 10 do
	pdf.text "Personal Projects & Accomplishments", :size => 16, :style => :bold
end

indent(pdf, 15) do
  @accomplishments.each do |accomplishment|
  	pdf.pad 5 do
  		pdf.text accomplishment.description
  	end
  end
end

