require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ContactInfo do
  fixtures :contact_infos
  
  before(:each) do
    @valid_create_attributes = {
      :key => 'name',
      :value => 'spike'
    }
    
    @missing_key_attributes = {
      :value => 'spike'
    }
    
    @missing_value_attributes = {
      :key => 'name'
    }
    
    @duplicate_key_attributes = {
      :key => 'email',
      :value => 'blah@blah.com'
    }
  end

  it "should be valid" do
    ContactInfo.new(@valid_create_attributes).should be_valid
  end
  
  it "should require key" do
    ContactInfo.new(@missing_key_attributes).should_not be_valid
  end
  
  it "should require value" do
    ContactInfo.new(@missing_value_attributes).should_not be_valid
  end
  
  it "should require that key is unique" do
    ContactInfo.new(@duplicate_key_attributes).should_not be_valid
  end
end
