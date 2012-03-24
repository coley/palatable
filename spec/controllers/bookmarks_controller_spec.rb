require 'spec_helper'

describe BookmarksController do
  render_views
  
  before(:each) do
    @base_title = "pal.atab.le"
  end
  
  #index tests
  #----------------------------------
  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'index'
      response.should have_selector("title",
                        :content => @base_title + " | home")
    end
  end

  #new tests
  #----------------------------------
  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'new'
      response.should have_selector("title",
                        :content => @base_title + " | add bookmark")
    end
   end

  #show tests
  #--------------------------------
  describe "GET 'show'" do
    
    before(:each) do
      @bookmark = Factory(:bookmark)
    end

    it "should be successful" do
      get :show, :id => @bookmark
      response.should be_success
    end
    
    it "should have the right title" do
      get :show, :id => @bookmark
      response.should have_selector("title",
                        :content => @base_title + " | show bookmark")
    end

    it "should find the right bookmark" do
      get :show, :id => @bookmark
      assigns(:bookmark).should == @bookmark
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

end
