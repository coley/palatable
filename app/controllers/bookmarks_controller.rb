class BookmarksController < ApplicationController
  
  def index
    @bookmarks = Bookmark.all

    respond_to do |format|
      format.html 
      format.xml  { render :xml => @bookmarks }
    end
  end
    
 def show
    @bookmark = Bookmark.find(params[:id])

    respond_to do |format|
      format.html 
      format.xml  { render :xml => @bookmark }
    end
  end

  def new
    @bookmark = Bookmark.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @bookmark }
    end
  end

  def create
    @bookmark = Bookmark.new(params[:bookmark])

    respond_to do |format|
      if @bookmark.save
        format.html { redirect_to(@bookmark, :notice => 'Bookmark was successfully created.') }
        format.xml  { render :xml => @bookmark, :status => :created, :location => @bookmark }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bookmark.errors, :status => :unprocessable_entity }
      end
    end
  end

end
