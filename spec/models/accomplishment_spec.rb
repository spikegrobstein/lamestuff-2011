require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Accomplishment do
  before(:each) do
    @valid_attributes = {
      :description => 'this is a description'
    }
    
    @missing_description_attributes = {
      
    }
  end

  it "should be valid with valid attributes" do
    Accomplishment.new(@valid_attributes).should be_valid
  end
  
  it "should be require a description" do
    Accomplishment.new(@missing_description_attributes).should_not be_valid
  end
end
