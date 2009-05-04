require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Skill do
  before(:each) do
    @valid_attributes = {
      :description => 'this is a description'
    }
    
    @missing_description_attributes = {
      
    }
  end

  it "should be valid" do
    Skill.new(@valid_attributes).should be_valid
  end
  
  it "should require a description" do
    Skill.new(@missing_description_attributes).should_not be_valid
  end
  
end
