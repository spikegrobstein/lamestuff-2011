require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Experience do
  before(:each) do
    @valid_attributes = {
      :place => 'Painters Inc.',
      :description => 'I like to paint stuff'
    }
    
    @missing_place_attributes = {
      :description => 'I like to paint stuff'
    }
    
    @missing_description_attributes = {
      :place => 'Painters Inc.'
    }
  end

  it "should be valid" do
    Experience.new(@valid_attributes).should be_valid
  end
  
  it "should require place" do
    Experience.new(@missing_place_attributes).should_not be_valid
  end
  
  it "should require description" do
    Experience.new(@missing_description_attributes).should_not be_valid
  end
  
end
