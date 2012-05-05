class BookmarksController < ApplicationController
  
  before_filter :authenticate, :only => [:index, :new, :create]
  before_filter :authorized_user, :only => [:show, :edit, :update, :destroy]

  def index
    @bookmarks = @current_user.bookmarks
    @title = "home"
  end
    
 def show
    @bookmark = Bookmark.find(params[:id])
    @title = "show bookmark"
    @bookmarkCount = Bookmark.find(:all,
                                   :conditions  => ["LOWER(url) = ?", @bookmark.url.downcase]).count
    @allBookmarkUsers = User.find(:all,
                                  :conditions  => ["LOWER(url) = ?", @bookmark.url.downcase],
                                  :joins => :bookmarks)
  end

  def new
    @bookmark = Bookmark.new
    @title = "add bookmark"
  end

  def create
    @bookmark = @current_user.bookmarks.create(params[:bookmark])
    @title = "bookmark added"

    if @bookmark.save
        redirect_to(allBookmarks_path, :notice => 'bookmark was successfully created') 
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
    
    if @bookmark.destroy
      flash[:success] = "bookmark was successfully deleted"
      redirect_to allBookmarks_path
    else
      @title = "update bookmark"
      render 'edit'
    end
  end

 private

    def authenticate
       if !signed_in?
        deny_access
      end
      
    end
    
    def authorized_user
            
      if signed_in?
        @bookmark = current_user.bookmarks.find_by_id(params[:id])
      
        if @bookmark.nil?
          deny_access
        end

      else
        authenticate
      end
    end
    
end
