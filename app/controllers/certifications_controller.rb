class CertificationsController < ApplicationController
  before_filter :login_required
  
  def index
    @certifications = Certification.find(:all, :order => :position)
  end
  
  def show
    @certification = Certification.find(params[:id])
  end

  def new
    @certification = Certification.new
  end

  def create
    @certification = Certification.new(params[:certification])
    
    begin
      @certification.save!
      
      flash[:notice] = "Successfully created new Certification"
      redirect_to certifications_path
    rescue ActiveRecord::RecordInvalid
      render :action => 'new'
    end
  end

  def edit
    @certification = Certification.find(params[:id])
  end

  def update
    @certification = Certification.find(params[:id])
    
    if @certification.update_attributes(params[:certification])
      flash[:notice] = "Successfully saved Certification"
      redirect_to certifications_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @certification = Certification.find(params[:id])
    @certification.destroy
    
    flash[:notice] = 'Successfully deleted Certification'
    redirect_to certifications_path
  end
  
  def move
    if ["move_lower", "move_higher", "move_to_top", "move_to_bottom"].include?(params[:move]) and params[:id] =~ /^\d+$/
      Certification.find(params[:id]).send(params[:move])
      redirect_to certifications_path
    end
  end
end
