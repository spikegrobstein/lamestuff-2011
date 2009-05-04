class AccomplishmentsController < ApplicationController
  before_filter :login_required
  
  def index
    @accomplishments = Accomplishment.find(:all, :order => :position)
  end
  
  def show
    @accomplishment = Accomplishment.find(params[:id])
  end

  def new
    @accomplishment = Accomplishment.new
  end

  def create
    @accomplishment = Accomplishment.new(params[:accomplishment])
    
    begin
      @accomplishment.save!
      
      flash[:notice] = "Successfully created new Accomplishment"
      redirect_to accomplishments_path
    rescue ActiveRecord::RecordInvalid
      render :action => 'new'
    end
  end

  def edit
    @accomplishment = Accomplishment.find(params[:id])
  end

  def update
    @accomplishment = Accomplishment.find(params[:id])
    
    if @accomplishment.update_attributes(params[:accomplishment])
      flash[:notice] = "Successfully saved Accomplishment"
      redirect_to accomplishments_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @accomplishment = Accomplishment.find(params[:id])
    @accomplishment.destroy
    
    flash[:notice] = 'Successfully deleted Accomplishment'
    redirect_to accomplishments_path
  end
  
  def move
    if ["move_lower", "move_higher", "move_to_top", "move_to_bottom"].include?(params[:move]) and params[:id] =~ /^\d+$/
      Accomplishment.find(params[:id]).send(params[:move])
      redirect_to accomplishments_path
    end
  end
end
