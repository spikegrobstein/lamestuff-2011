class CreateHomeMessages < ActiveRecord::Migration
  def self.up
    create_table :home_messages do |t|
      t.text :description
      t.timestamps
    end
    
    m = HomeMessage.new
    m.description = "Welcome to my site!"
    m.save!
  end

  def self.down
    drop_table :home_messages
  end
end
