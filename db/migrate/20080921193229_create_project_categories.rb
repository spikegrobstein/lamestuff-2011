class CreateProjectCategories < ActiveRecord::Migration
  def self.up
    create_table :project_categories do |t|
      t.integer :project_id
      t.integer :category_id
      t.timestamps
    end
  end

  def self.down
    drop_table :project_categories
  end
end
