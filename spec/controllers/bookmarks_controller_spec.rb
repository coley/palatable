require 'spec_helper'

describe BookmarksController do
  render_views
  
  before(:each) do
    @base_title = "pal.atab.le"
  end
  
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

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'new'
      response.should have_selector("title",
                        :content => @base_title + " | new bookmark")
    end
   end

end
