class CreateProjectElements < ActiveRecord::Migration
  def self.up
    create_table :project_elements do |t|
      t.string :blurb
      t.integer :position
      t.integer :project_id
      
      t.timestamps
    end
    
    add_index :project_elements, :project_id
  end

  def self.down
    drop_table :project_elements
  end
end
