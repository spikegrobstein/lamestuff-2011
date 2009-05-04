class ExperiencesController < ApplicationController
  before_filter :login_required
  
  def index
    @experiences = Experience.find(:all, :order => :position)
  end
  
  def show
    @experience = Experience.find(params[:id])
  end

  def new
    @experience = Experience.new
  end

  def create
    @experience = Experience.new(params[:experience])
    
    begin
      @experience.save!
      
      flash[:notice] = "Successfully created new Experience"
      redirect_to experiences_path
    rescue ActiveRecord::RecordInvalid
      render :action => 'new'
    end
  end

  def edit
    @experience = Experience.find(params[:id])
  end

  def update
    @experience = Experience.find(params[:id])
    
    if @experience.update_attributes(params[:experience])
      flash[:notice] = "Successfully saved Experience"
      redirect_to experiences_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @experience = Experience.find(params[:id])
    @experience.destroy
    
    flash[:notice] = 'Successfully deleted Experience'
    redirect_to experiences_path
  end
  
  def move
    if ["move_lower", "move_higher", "move_to_top", "move_to_bottom"].include?(params[:move]) and params[:id] =~ /^\d+$/
      Experience.find(params[:id]).send(params[:move])
      redirect_to experiences_path
    end
  end
end
