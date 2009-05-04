require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Project do
  fixtures :projects, :project_elements, :categories, :project_categories
  
  before(:each) do
    @valid_attributes = {
      :title => 'Some Project',
      :content_type => 'image/jpeg',
      :size => '12345',
      :filename => 'blah.jpg'
    }
    
    @duplicate_title_attributes = {
      :title => 'Boobs',
      :content_type => 'image/jpeg',
      :size => '12345',
      :filename => 'blah.jpg'
    }
    
    @missing_title_attributes = {
      :content_type => 'image/jpeg',
      :size => '12345',
      :filename => 'blah.jpg'
    }
    
  end

  it "should be valid" do
    Project.new(@valid_attributes).should be_valid
  end
  
  it "should require title" do
    Project.new(@missing_title_attributes).should_not be_valid
  end 
  
  it "should require that title is unique" do
    Project.new(@duplicate_title_attributes).should_not be_valid
  end
  
  it "should know how to access its project_elements" do
    Project.find(1).elements.count.should == 2
  end
  
  it "should know how to access its categories" do
    Project.find(1).categories.count.should == 2
  end
end
