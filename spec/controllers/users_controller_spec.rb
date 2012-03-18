require 'spec_helper'

describe UsersController do
  render_views
  
  before(:each) do
    @base_title = "pal.atab.le"
  end
  
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
  
  describe "GET 'show'" do
    it "should be successful" do
      get :show, :id => 12
      response.should be_success
    end
    
    it "should have the right title" do
      get :show, id => 12
      response.should have_selector("title",
                        :content => @base_title + " | view profile")
    end
  end

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
  
  describe "GET 'edit'" do
    it "should be successful" do
      get :edit, :id => 12
      response.should be_success
    end
    
    it "should have the right title" do
      get :edit, id => 12
      response.should have_selector("title",
                        :content => @base_title + " | update profile")
    end
  end

end
