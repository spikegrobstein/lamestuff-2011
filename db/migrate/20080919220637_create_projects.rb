class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.integer :thumbnail_id
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
