class CreateArtworks < ActiveRecord::Migration
  def self.up
    create_table :artworks do |t|
      t.integer :size
      t.string :content_type
      t.string :filename
      t.integer :height
      t.integer :width
      t.integer :parent_id

      t.timestamps
    end
  end

  def self.down
    drop_table :artworks
  end
end
