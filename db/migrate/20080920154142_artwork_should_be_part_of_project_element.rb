class ArtworkShouldBePartOfProjectElement < ActiveRecord::Migration
  def self.up
    add_column :project_elements, :size,          :integer
    add_column :project_elements, :content_type,  :string 
    add_column :project_elements, :filename,      :string 
    add_column :project_elements, :height,        :integer
    add_column :project_elements, :width,         :integer
    add_column :project_elements, :parent_id,     :integer
  end

  def self.down
    remove_column :project_elements, :size
    remove_column :project_elements, :content_type
    remove_column :project_elements, :filename
    remove_column :project_elements, :height
    remove_column :project_elements, :width    
    remove_column :project_elements, :parent_id
  end
end
