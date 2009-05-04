class PortfolioController < ApplicationController
  before_filter :login_required, :only => [ :edit, :create, :new, :destroy, :update ]
  before_filter :build_lists, :only => [ :edit, :update ]
  
  def index
    @projects = Project.find(:all, :order => :position)
		@categories = Category.find(:all)
  end
  
  def show
    if params[:category_name].blank?
      unless params[:id].blank?
        @project = Project.find(params[:id])
      end
    
      unless params[:name].blank?
        @project = Project.find_by_url_path(params[:name])
      end
    
      projects = Project.find(:all)
      @previous_project = projects[projects.index(@project) - 1] unless projects.index(@project) == 0
      @next_project = projects[projects.index(@project) + 1]
    else
      category = Category.find_by_url_path(params[:category_name])
      @project = category.projects.find_by_url_path(params[:project_name])
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    
    begin
      @project.save!
      
      flash[:notice] = "Successfully created new Project"
      redirect_to edit_project_path(@project)
    rescue ActiveRecord::RecordInvalid
      render :action => 'new'
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    
    if @project.update_attributes(params[:project])
      flash[:notice] = "Successfully saved Project"
      redirect_to edit_project_path(@project)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    
    flash[:notice] = 'Successfully deleted Project'
    redirect_to portfolio_path
  end
  
  def move
    if ["move_lower", "move_higher", "move_to_top", "move_to_bottom"].include?(params[:move]) and params[:id] =~ /^\d+$/
      if params[:type].nil?
        Project.find(params[:id]).send(params[:move])
        redirect_to portfolio_path
      elsif params[:type] == 'ProjectElement'
        p = ProjectElement.find(params[:id])
        p.send(params[:move])
        redirect_to edit_project_path(p.project)
      end
    end

  end
  
  private
  
  def build_lists
    @category_list = category_list
  end
  
end
