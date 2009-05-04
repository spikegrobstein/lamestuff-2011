class CreateExperiences < ActiveRecord::Migration
  def self.up
    create_table :experiences do |t|
      t.string :location
      t.string :place
      t.integer :position
      t.string :work_position
      t.string :industry
      t.date :start_date
      t.date :end_date
      t.text :description
      
      t.timestamps
    end
  end

  def self.down
    drop_table :experiences
  end
end
