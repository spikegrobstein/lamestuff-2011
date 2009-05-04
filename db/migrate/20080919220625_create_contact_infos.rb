class CreateContactInfos < ActiveRecord::Migration
  def self.up
    create_table :contact_infos do |t|
      t.string :key
      t.string :value
      t.string :link
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :contact_infos
  end
end
