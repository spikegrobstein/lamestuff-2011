class CreateThumbnailAttachmentForProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :size,          :integer
    add_column :projects, :content_type,  :string 
    add_column :projects, :filename,      :string 
    add_column :projects, :height,        :integer
    add_column :projects, :width,         :integer
    add_column :projects, :parent_id,     :integer
  end

  def self.down
    remove_column :projects, :size
    remove_column :projects, :content_type
    remove_column :projects, :filename
    remove_column :projects, :height
    remove_column :projects, :width    
    remove_column :projects, :parent_id
  end
end
