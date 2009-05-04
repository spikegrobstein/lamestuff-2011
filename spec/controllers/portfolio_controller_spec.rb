require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PortfolioController do
  fixtures :projects, :project_elements, :users

  #Delete these examples and add some real ones
  it "should use PortfolioController" do
    controller.should be_an_instance_of(PortfolioController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end
  
  describe "GET 'show'" do
    it "should be successful" do
      get 'show', :id => 1
      response.should be_success
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
          Project.any_instance.stubs(:valid?).returns(true)
          Project.any_instance.stubs(:create_url_path).returns('awesome-url-path')
          
        
          post 'create'
          assigns[:project].should_not be_new_record
          flash[:notice].should_not be_nil
          response.should redirect_to(edit_project_path(assigns[:project]))
        end
      end

      describe "POST 'update'" do
        it "should be successful" do
          Project.any_instance.stubs(:valid?).returns(true)
          Project.any_instance.stubs(:create_url_path).returns('awesome-url-path')
          
        
          post 'update', :id => 1
          assigns[:project].should be_valid
          flash[:notice].should_not be_nil
          response.should redirect_to(edit_project_path)
        end
      end
    end
    
    describe "when working with an invalid item" do
      describe "POST 'create'" do
        it "should be successful" do
          Project.any_instance.stubs(:valid?).returns(false)
        
          post 'create'
          assigns[:project].should_not be_valid
          response.should render_template(:new)
        end
      end

      describe "POST 'update'" do
        it "should be successful" do
          Project.any_instance.stubs(:valid?).returns(false)
        
          post 'update', :id => 1
          assigns[:project].should_not be_valid
          response.should render_template(:edit)
        end
      end
    end
    
    describe "POST 'destroy'" do
      it "should be successful" do
        delete :destroy, :id => 2

        flash[:notice].should_not be_nil
        flash[:error].should be_nil
        response.should redirect_to(portfolio_path)
      end
    end
  end
end
