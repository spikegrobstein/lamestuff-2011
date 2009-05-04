require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProjectElement do
  fixtures :projects, :project_elements
  
  before(:each) do
    @valid_attributes = {
      :content_type => 'image/jpeg',
      :size => '12345',
      :filename => 'blah.jpg'
    }
  end

  it "should be valid" do
    ProjectElement.new(@valid_attributes).should be_valid
  end
  
  it "should require attachment attributes" do
    ProjectElement.new.should_not be_valid
  end
  
  it "should know how to access it's project" do
    ProjectElement.find(1).project.title.should == 'Boobs'
  end
end
