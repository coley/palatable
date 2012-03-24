require 'spec_helper'

describe UsersController do
  render_views
  
  before(:each) do
    @base_title = "pal.atab.le"
  end
  
  #login tests
  #----------------------------------
  describe "GET 'login'" do
    it "should be successful" do
      get 'login'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'login'
      response.should have_selector("title",
                        :content => @base_title + " | login")
    end
  end
  
  #dashboard tests
  #--------------------------------
  describe "GET 'dashboard'" do
    it "should be successful" do
      get 'dashboard'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'dashboard'
      response.should have_selector("title",
                        :content => @base_title + " | dashboard")
    end
  end
  
  #show tests
  #--------------------------------
  describe "GET 'show'" do
    
    before(:each) do
      @user = Factory(:user)
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
  describe "GET 'create'" do
    it "should be successful" do
      get 'create'
      response.should be_success
    end
  end

  #edit tests
  #--------------------------------
    describe "GET 'edit'" do
    
    before(:each) do
      @user = Factory(:user)
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
  describe "GET 'update'" do
    
    before(:each) do
      @user = Factory(:user)
    end

    it "should be successful" do
      get :update, :id => @user
      response.should be_success
    end
    
    it "should find the right user" do
      get :update, :id => @user
      assigns(:user).should == @user
    end
    
  end

end
