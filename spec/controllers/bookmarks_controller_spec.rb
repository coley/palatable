require 'spec_helper'

describe BookmarksController do
  render_views
  
  before(:each) do
    @base_title = "pal.atab.le"
  end
  
  #access control tests
  #----------------------------------
  describe "access control" do

    it "should deny access to 'index'" do
      get :index
      response.should redirect_to(signin_path)
    end
    
    it "should deny access to 'show'" do
      get :show, :id => 1
      response.should redirect_to(signin_path)
    end    
    
    it "should deny access to 'edit'" do
      get :edit, :id => 1
      response.should redirect_to(signin_path)
    end
    
    it "should deny access to 'update'" do
      post :update, :id => 1
      response.should redirect_to(signin_path)
    end
    
    it "should deny access to 'new'" do
      get :new
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end
    
  #index tests
  #----------------------------------
  describe "GET 'index'" do
    
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

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
    
    before(:each) do
      @user = Factory(:user)
      @bookmark = Factory(:bookmark)
      test_sign_in(@user)
    end
    
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
      @user = Factory(:user)
      test_sign_in(@user)
      @attr = { :name => "apple", :url => "http://www.testing.com" }
      @attr2 = { :name => "apple2", :url => "http://www.testing2.com" }
      @bookmark = @user.bookmarks.create!(@attr)
    end
    
    it "should create a new instance given valid attributes" do
        @user.bookmarks.create!(@attr2)
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
  describe "POST 'create'" do
    
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
      @attr = { :name => "apple", :url => "http://www.apple.com" }
      @bookmark = @user.bookmarks.create!(@attr)
    end

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
      test_sign_in(@user)
      @attr = { :name => "apple", :url => "http://www.apple.com" }
      @bookmark = @user.bookmarks.create!(@attr)
    end

    it "should be successful" do
      get :edit, :id => @bookmark
      response.should be_success
    end
    
    it "should have the right title" do
      get :edit, :id => @bookmark
      response.should have_selector("title",
                        :content => @base_title + " | update bookmark")
    end

    it "should find the right bookmark" do
      get :edit, :id => @bookmark
      assigns(:bookmark).should == @bookmark
    end
    
  end
  
  #update tests
  #--------------------------------
  describe "PUT 'update'" do
    
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
      @attr = { :name => "apple", :url => "http://www.apple.com" }
      @bookmark = @user.bookmarks.create!(@attr)
    end

  describe "failure" do

      before(:each) do
        @attr = { :name => "",
                  :url => "" }
      end

      it "should render the 'edit' page" do
        put :update, :id => @bookmark, :bookmark => @attr
        response.should render_template('edit')
      end
    end

  describe "success" do

      before(:each) do
        @attr = { :name => "madison colleage",
                  :url => "http://www.madisoncollege.edu" }
      end

      it "should change the bookmarks's attributes" do
        put :update, :id => @bookmark, :bookmark => @attr
        @bookmark.reload
        @bookmark.name.should  == @attr[:name]
        @bookmark.url.should == @attr[:url]
      end

      it "should redirect to the bookmark show page" do
        put :update, :id => @bookmark, :bookmark => @attr
        response.should redirect_to(bookmark_path(@bookmark))
      end

      it "should have a flash message" do
        put :update, :id => @bookmark, :bookmark => @attr
        flash[:success].should =~ /bookmark was successfully updated/
      end
    end
  end
  
  #delete tests
  #--------------------------------
  describe "DELETE 'destroy'" do

    describe "for an unauthorized user" do

      before(:each) do
        @user = Factory(:user)
        wrong_user = Factory(:user, :id => 999, :username => "anotheruser")
        test_sign_in(wrong_user)
        @bookmark = Factory(:bookmark, :user => @user)
      end

      it "should deny access" do
        delete :destroy, :id => @bookmark
        response.should redirect_to(signin_path)
      end
    end

    describe "for an authorized user" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
        @bookmark = Factory(:bookmark, :user => @user)
      end

      it "should destroy the bookmark" do
        lambda do 
          delete :destroy, :id => @bookmark
        end.should change(Bookmark, :count).by(-1)
      end
    end
  end


end
