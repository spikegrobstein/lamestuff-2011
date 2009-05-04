class CategoriesController < ApplicationController
  before_filter :login_required, :only => [ :new, :edit, :destroy, :update, :create ]
  
  def index
    all_categories = Category.find(:all, :order => :name)
		if @current_user.nil?
			@categories = []
			all_categories.each do |c|
				@categories << c if c.projects.count > 0
			end
		else
			@categories = all_categories
		end
  end

  def new
    @category = Category.new
  end
  
  def show    
    unless params[:id].blank?
      @category = Category.find(params[:id])
    end
    
    unless params[:name].blank?
      @category = Category.find_by_url_path(params[:name])
    end
    
    @projects = @category.projects unless @category.nil?
  end

  def create
    @category = Category.new(params[:category])
    
    begin
      @category.save!
      
      flash[:notice] = "Successfully created new Category"
      redirect_to categories_path
    rescue ActiveRecord::RecordInvalid
      render :action => 'new'
    end
  end

  def edit
    unless params[:id].blank?
      @category = Category.find(params[:id])
    end
    
    unless params[:name].blank?
      @category = Category.find_by_name(params[:name].gsub(/-|_/, ' '))
    end
  end

  def update
    @category = Category.find(params[:id])
    
    if @category.update_attributes(params[:category])
      flash[:notice] = "Successfully saved Category"
      redirect_to categories_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    
    flash[:notice] = 'Successfully deleted Category'
    redirect_to categories_path
  end
end
