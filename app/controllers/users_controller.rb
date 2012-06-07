class UsersController < ApplicationController
  
  before_filter :authenticate, :only => [:edit_password, :update_password]
  before_filter :authorized_user, :only => [:show, :edit, :update]
  before_filter :new_user, :only => [:new]
 
  def show
    @title = "view profile"
    @user = User.find(params[:id])
    @bookmarks = @user.bookmarks
  end

  def new
    @title = "sign up"
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if (@user.save)
      sign_in @user
      flash[:success] = "welcome to pal.atab.le"
      redirect_to allBookmarks_path
    else
      @title = "sign up"
      render 'new'
    end
  end

  def edit
    @title = "update profile"
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
        
    if @user.update_attributes(params[:user])
        flash[:success] = "profile was successfully updated"
        redirect_to @user
    else
        @title = "update profile"
        render 'edit' 
    end
  end
  
  def edit_password
    @title = "update password"
    @user = current_user
  end
  
  def update_password
    @user = current_user
    @user.updating_password = true;
    
    if @user.update_attributes(params[:user])
          sign_in(@user)
          flash[:success] = "password was successfully updated"
          redirect_to @user
    else
          @title = "update password"
          render 'edit_password' 
    end
  
  end

    
 private
 
    def new_user
      
      if signed_in?
        redirect_to allBookmarks_path
      end
      
    end

    def authenticate
      
      if !signed_in?
        deny_access
      end
      
    end
    
    def authorized_user
      
      if signed_in?
          @userLoggedIn = current_user
          @userAccess = User.find(params[:id])
      
            if @userLoggedIn.id != @userAccess.id
              deny_access
            end
      else
        authenticate
      end
    end

end
