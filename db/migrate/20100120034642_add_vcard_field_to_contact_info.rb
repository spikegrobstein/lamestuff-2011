class AddVcardFieldToContactInfo < ActiveRecord::Migration
  def self.up
    add_column :contact_infos, :vcard_field, :string
  end

  def self.down
    remove_column :contact_infos, :vcard_field
  end
end
