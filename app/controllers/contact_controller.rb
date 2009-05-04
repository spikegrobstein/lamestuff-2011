class ContactController < ApplicationController
  before_filter :login_required, :only => [ :edit, :create, :new, :destroy, :update ]
  
  def index
    @contact_infos = ContactInfo.find(:all, :order => :position)
  end
  
  def show
    index
  end
  
  def new
    @contact_info = ContactInfo.new
  end
  
  def create
    @contact_info = ContactInfo.new(params[:contact_info])
    
    begin
      @contact_info.save!
      
      flash[:notice] = "#{@contact_info.key} has been created!"
      redirect_to contact_infos_path
    rescue ActiveRecord::RecordInvalid
      render :action => 'new'
    end
  end
  
  def edit
    @contact_info = ContactInfo.find(params[:id])
  end
  
  def update
    @contact_info = ContactInfo.find(params[:id])
    
    if @contact_info.update_attributes(params[:contact_info])
      flash[:notice] = "#{@contact_info.key} has been saved!"
      
      redirect_to contact_infos_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @contact_info = ContactInfo.find(params[:id])
    @contact_info.destroy
    flash[:notice] = "Successfully deleted contact info."
    
    redirect_to contact_infos_path
  end
  
  def move
    if ["move_lower", "move_higher", "move_to_top", "move_to_bottom"].include?(params[:move]) and params[:id] =~ /^\d+$/
      ContactInfo.find(params[:id]).send(params[:move])
    end

    redirect_to :action => :index
  end
  
end
