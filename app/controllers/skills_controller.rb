class SkillsController < ApplicationController
  before_filter :login_required
  
  def index
    @skills = Skill.find(:all, :order => :position)
  end
  
  def show
    @skill = Skill.find(params[:id])
  end

  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new(params[:skill])
    
    begin
      @skill.save!
      
      flash[:notice] = "Successfully created new Skill"
      redirect_to skills_path
    rescue ActiveRecord::RecordInvalid
      render :action => 'new'
    end
  end

  def edit
    @skill = Skill.find(params[:id])
  end

  def update
    @skill = Skill.find(params[:id])
    
    if @skill.update_attributes(params[:skill])
      flash[:notice] = "Successfully saved Skill"
      redirect_to skills_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @skill = Skill.find(params[:id])
    @skill.destroy
    
    flash[:notice] = 'Successfully deleted Skill'
    redirect_to skills_path
  end
  
  def move
    if ["move_lower", "move_higher", "move_to_top", "move_to_bottom"].include?(params[:move]) and params[:id] =~ /^\d+$/
      Skill.find(params[:id]).send(params[:move])
      redirect_to skills_path
    end
  end
end
