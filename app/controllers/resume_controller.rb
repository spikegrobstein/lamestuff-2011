class ResumeController < ApplicationController
  
  def show
    @objectives = Objective.find(:all, :order => :position)
    @certifications = Certification.find(:all, :order => :position)
    @skills = Skill.find(:all, :order => :position)
    @experiences = Experience.find(:all, :order => :position)
    @accomplishments = Accomplishment.find(:all, :order => :position)
    @contact_infos = ContactInfo.find(:all, :order => :position)
    
		@resume_contact_infos = ContactInfo.find_all_by_show_on_resume(true, :order => :position)
    
		respond_to do |format|
			format.html
			format.pdf {
				prawnto :prawn => {:page_size => 'LETTER' }, :filename => 'spike_grobstein_resume.pdf' 
				render :layout => false
			}
		end
  end
	
end
