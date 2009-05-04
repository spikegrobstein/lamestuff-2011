require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HomeController do
  fixtures :users, :home_messages

  #Delete these examples and add some real ones
  it "should use HomeController" do
    controller.should be_an_instance_of(HomeController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end
  
  describe "when not logged in" do
    describe "GET 'edit'" do
      it "should not be successful" do
        get 'edit'
        response.should_not be_success
      end
    end

    describe "GET 'update'" do
      it "should not be successful" do
        get 'update'
        response.should_not be_success
      end
    end
  end
  
  describe "when logged in" do
     before(:each) do
       session[:user_id] = 1
     end

     describe "GET 'edit'" do
       it "should be successful" do
         get 'edit', :id => 1
         response.should be_success
       end
     end

     describe "when working with a valid item" do
       describe "POST 'update'" do
         it "should be successful" do
           HomeMessage.any_instance.stubs(:valid?).returns(true)

           post 'update', :id => 1
           assigns[:home_message].should be_valid
           flash[:notice].should_not be_nil
           response.should redirect_to(home_path)
         end
       end
     end

     describe "when working with an invalid item" do
       describe "POST 'update'" do
         it "should be successful" do
           HomeMessage.any_instance.stubs(:valid?).returns(false)

           post 'update', :id => 1
           assigns[:home_message].should_not be_valid
           response.should render_template(:edit)
         end
       end
     end
   end
end
