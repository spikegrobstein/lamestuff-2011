class AddResumeOptionsToContactInfo < ActiveRecord::Migration
  def self.up
		add_column :contact_infos, :show_in_header, :boolean
		add_column :contact_infos, :show_on_resume, :boolean
  end

  def self.down
		remove_column :contact_infos, :show_in_header
		remove_column :contact_infos, :show_on_resume
  end
end
