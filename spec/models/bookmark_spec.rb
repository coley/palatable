# == Schema Information
#
# Table name: bookmarks
#
#  id         :integer         not null, primary key
#  url        :string(255)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#


require 'spec_helper'

describe Bookmark do
    
  before(:each) do
    @user = Factory(:user)
    @attr = { :name => "apple", :url => "http://www.apple.com" }
  end

  #creation bookmark tests
  #-------------------------
  it "should create a new instance given valid attributes" do
    @user.bookmarks.create!(@attr)
  end

  #user association tests
  #-------------------------
  describe "user associations" do

    before(:each) do
      @bookmark = @user.bookmarks.create(@attr)
    end

    it "should have a user attribute" do
      @bookmark.should respond_to(:user)
    end

    it "should have the right associated user" do
      @bookmark.user_id.should == @user.id
      @bookmark.user.should == @user
    end
  end
  
  #validation bookmark tests
  #-------------------------
  it "should require a name" do
    no_name_bookmark =  @user.bookmarks.new(@attr.merge(:name => ""))
    no_name_bookmark.should_not be_valid
  end
  
  it "should reject names that are too long" do
    long_name = "a" * 100
    long_name_bookmark = @user.bookmarks.new(@attr.merge(:name => long_name))
    long_name_bookmark.should_not be_valid
  end
  
  it "should require a url" do
    no_url_bookmark = @user.bookmarks.new(@attr.merge(:url => ""))
    no_url_bookmark.should_not be_valid
  end
  
  it "should reject urls that are too short" do
      short_url = "a" * 9
      short_url_bookmark =  @user.bookmarks.new(@attr.merge(:url => short_url))
      short_url_bookmark.should_not be_valid
  end
  
end
