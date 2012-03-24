class BookmarksController < ApplicationController
  
  def index
    @bookmarks = Bookmark.all(:order => "name")
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
    @bookmark = Bookmark.new(params[:bookmark])
    @title = "bookmark added"

    if @bookmark.save
        redirect_to(@bookmark, :notice => 'Bookmark was successfully created.') 
    else
        render :action => "new"
    end
  end

end
