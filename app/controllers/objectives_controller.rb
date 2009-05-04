class ObjectivesController < ApplicationController
  before_filter :login_required
  
  def index
    @objectives = Objective.find(:all, :order => :position)
  end
  
  def show
    @objective = Objective.find(params[:id])
  end

  def new
    @objective = Objective.new
  end

  def create
    @objective = Objective.new(params[:objective])
    
    begin
      @objective.save!
      
      flash[:notice] = "Successfully created new Objective"
      redirect_to objectives_path
    rescue ActiveRecord::RecordInvalid
      render :action => 'new'
    end
  end

  def edit
    @objective = Objective.find(params[:id])
  end

  def update
    @objective = Objective.find(params[:id])
    
    if @objective.update_attributes(params[:objective])
      flash[:notice] = "Successfully saved Objective"
      redirect_to objectives_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @objective = Objective.find(params[:id])
    @objective.destroy
    
    flash[:notice] = 'Successfully deleted Objective'
    redirect_to objectives_path
  end
  
  def move
    if ["move_lower", "move_higher", "move_to_top", "move_to_bottom"].include?(params[:move]) and params[:id] =~ /^\d+$/
      Objective.find(params[:id]).send(params[:move])
      redirect_to objectives_path
    end
  end
end
