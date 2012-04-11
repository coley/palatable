class BookmarksController < ApplicationController
  
  #before_filter :authenticate, :only => [:index, :show, :new, :create, :edit, :update]
  #before_filter :authorized_user, :only => [:destroy]
  
  before_filter :authenticate, :only => [:index, :new, :create]
  before_filter :authorized_user, :only => [:destroy, :show, :edit, :update]

  def index
    #@bookmarks = Bookmark.all(:order => "name")
    @bookmarks = @current_user.bookmarks
    @title = "home"
  end
    
 def show
    @bookmark = Bookmark.find(params[:id])
    @title = "show bookmark"
  end

  def new
    @bookmark = Bookmark.new
    @title = "add bookmark"
  end

  def create
    #@bookmark = Bookmark.new(params[:bookmark])
    @bookmark = @current_user.bookmarks.create(params[:bookmark])
    @title = "bookmark added"

    if @bookmark.save
        redirect_to(@bookmark, :notice => 'bookmark was successfully created') 
    else
        render :action => "new"
    end
  end
  
  def edit
    @title = "update bookmark"
    @bookmark = Bookmark.find(params[:id])
  end
  
  def update
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.update_attributes(params[:bookmark])
        flash[:success] = "bookmark was successfully updated"
        redirect_to @bookmark
    else
        @title = "update bookmark"
        render 'edit' 
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to allBookmarks_path
  end

 private

    def authenticate
       if !signed_in?
        flash[:error] = "please sign in to access this page"
        deny_access
      end
      
      #deny_access unless signed_in?
    end
    
    def authorized_user
            
      if signed_in?
        @bookmark = current_user.bookmarks.find_by_id(params[:id])
      
        if @bookmark.nil?
          deny_access
        end
        #redirect_to root_path if @bookmark.nil?

      else
        authenticate
      end
    end
    
end
