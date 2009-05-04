require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Category do
  fixtures :categories, :projects, :project_categories
  
  before(:each) do
    @valid_attributes = {
      :name => 'some category'
    }
    
    @missing_name_attributes = {
      
    }
  end

  it "should be valid with valid attributes" do
    Category.new(@valid_attributes).should be_valid
  end
  
  it "should require name attribute" do
    Category.new(@missing_name_attributes).should_not be_valid
  end
  
  it "should know how to access its projects" do
    Category.find(1).projects.count.should == 1
  end
end
