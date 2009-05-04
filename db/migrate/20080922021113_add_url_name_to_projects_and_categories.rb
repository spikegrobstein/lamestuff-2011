class AddUrlNameToProjectsAndCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :url_path, :string
    add_column :projects, :url_path, :string
  end

  def self.down
    remove_column :categories, :url_path
    remove_column :projects, :url_path
  end
end
