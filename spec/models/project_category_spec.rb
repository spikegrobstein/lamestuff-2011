require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProjectCategory do
  before(:each) do
    @project_category = ProjectCategory.new
  end

  it "should be valid" do
    @project_category.should be_valid
  end
  
end
