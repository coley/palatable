require 'spec_helper'

describe UsersController do
  render_views
  
  before(:each) do
    @base_title = "pal.atab.le"
  end
  
  #access control tests
  #----------------------------------
  describe "access control" do
    
    it "should deny access to 'edit'" do
      get :edit, :id => 1
      response.should redirect_to(signin_path)
    end
    
    it "should deny access to 'update'" do
      post :update, :id => 1
      response.should redirect_to(signin_path)
    end
    
    it "should deny access to 'show'" do
      get :show, :id => 1
      response.should redirect_to(signin_path)
    end    

  end
      
  #show tests
  #--------------------------------
  describe "GET 'show'" do
    
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end
    
    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end
    
    it "should have the right title" do
      get :show, :id => @user
      response.should have_selector("title",
                        :content => @base_title + " | view profile")
    end

    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end
    
  end
  
  #new tests
  #--------------------------------
  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'new'
      response.should have_selector("title",
                        :content => @base_title + " | sign up")
    end
  end
  
  #create tests
  #--------------------------------
  describe "POST 'create'" do
    
    describe "success" do
      
      before(:each) do
        @attr = { :username => "maryjonestest",
                  :full_name => "Mary Jones",
                  :email => "maryjones@gmail.com",
                  :password => "foobar12",
                  :password_confirmation => "foobar12" }
      end

      it "should be successful" do
        get 'create'
        response.should be_success
      end
  
      it "should sign the user in" do
        post :create, :user => @attr
        controller.should be_signed_in
      end
    end
    
  end

  #edit tests
  #--------------------------------
    describe "GET 'edit'" do
    
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

    it "should be successful" do
      get :edit, :id => @user
      response.should be_success
    end
    
    it "should have the right title" do
      get :edit, :id => @user
      response.should have_selector("title",
                        :content => @base_title + " | update profile")
    end

    it "should find the right user" do
      get :edit, :id => @user
      assigns(:user).should == @user
    end
    
  end
    
  #update tests
  #--------------------------------
  describe "PUT 'update'" do
    
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

  describe "failure" do

      before(:each) do
        @attr = { :username => "",
                  :full_name => "",
                  :email => "",
                  :password => "",
                  :password_confirmation => "" }
      end

      it "should render the 'edit' page" do
        put :update, :id => @user, :user => @attr
        response.should render_template('edit')
      end

      it "should have the right title" do
        put :update, :id => @user, :user => @attr
        response.should have_selector("title",
                            :content => @base_title + " | update profile")
      end
    end

  describe "success" do

      before(:each) do
        @attr = { :username => "maryjones10",
                  :full_name => "Mary Jones",
                  :email => "maryjones@gmail.com",
                  :password => "foobar12",
                  :password_confirmation => "foobar12" }
      end

      it "should change the user's attributes" do
        put :update, :id => @user, :user => @attr
        @user.reload
        @user.full_name.should  == @attr[:full_name]
        @user.email.should == @attr[:email]
      end

      it "should redirect to the user show page" do
        put :update, :id => @user, :user => @attr
        response.should redirect_to(user_path(@user))
      end

      it "should have a flash message" do
        put :update, :id => @user, :user => @attr
        flash[:success].should =~ /profile was successfully updated/
      end
    end
  end
  
  #authentication tests
  #--------------------------------
  describe "authentication of edit/update/show pages" do

    before(:each) do
      @user = Factory(:user)
    end

    describe "for non-signed-in users" do

      it "should deny access to 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(signin_path)
      end
      
      it "should deny access to 'show'" do
        get :show, :id => @user
        response.should redirect_to(signin_path)
      end

      it "should deny access to 'update'" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(signin_path)
      end
    end
  end
end
