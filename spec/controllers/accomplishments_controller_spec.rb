require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AccomplishmentsController do
  fixtures :accomplishments, :users

  #Delete these examples and add some real ones
  it "should use AccomplishmentsController" do
    controller.should be_an_instance_of(AccomplishmentsController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should_not be_success
    end
  end
  
  describe "GET 'show'" do
    it "should be successful" do
      get 'show', :id => 1
      response.should_not be_success
    end
  end

  describe "not logged in" do
    describe "GET 'new'" do
      it "should not be successful" do
        get 'new'
        response.should_not be_success
      end
    end

    describe "GET 'create'" do
      it "should not be successful" do
        get 'create'
        response.should_not be_success
      end
    end

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
    
    describe "GET 'new'" do
      it "should be successful" do
        get 'new'
        response.should be_success
      end
    end
    
    describe "GET 'edit'" do
      it "should be successful" do
        get 'edit', :id => 1
        response.should be_success
      end
    end
    
    describe "when working with a valid item" do
      describe "POST 'create'" do
        it "should be successful" do
          Accomplishment.any_instance.stubs(:valid?).returns(true)
        
          post 'create'
          assigns[:accomplishment].should_not be_new_record
          flash[:notice].should_not be_nil
          response.should redirect_to(accomplishments_path)
        end
      end

      describe "POST 'update'" do
        it "should be successful" do
          Accomplishment.any_instance.stubs(:valid?).returns(true)
        
          post 'update', :id => 1
          assigns[:accomplishment].should be_valid
          flash[:notice].should_not be_nil
          response.should redirect_to(accomplishments_path)
        end
      end
    end
    
    describe "when working with an invalid item" do
      describe "POST 'create'" do
        it "should be successful" do
          Accomplishment.any_instance.stubs(:valid?).returns(false)
        
          post 'create'
          assigns[:accomplishment].should_not be_valid
          response.should render_template(:new)
        end
      end

      describe "POST 'update'" do
        it "should be successful" do
          Accomplishment.any_instance.stubs(:valid?).returns(false)
        
          post 'update', :id => 1
          assigns[:accomplishment].should_not be_valid
          response.should render_template(:edit)
        end
      end
    end
    
    describe "POST 'destroy'" do
      it "should be successful" do
        delete :destroy, :id => 1

        flash[:notice].should_not be_nil
        flash[:error].should be_nil
        response.should redirect_to(accomplishments_path)
      end
    end
  end

end
