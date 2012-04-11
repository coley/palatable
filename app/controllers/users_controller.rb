class UsersController < ApplicationController
  
  #before_filter :authenticate, :only => [:edit, :update, :show]
  before_filter :authorized_user, :only => [:show, :edit, :update]
 
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
      flash[:success] = "welcome to Pal.atab.le"
      #redirect_to @user
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

    def authenticate
      
      if !signed_in?
        flash[:error] = "please sign in to access this page"
        deny_access
      end
      
      #deny_access unless signed_in?
    end
    
    def authorized_user
      
      if signed_in?
          @userLoggedIn = current_user
          @userAccess = User.find(params[:id])
      
            if @userLoggedIn.id != @userAccess.id
              flash[:error] = "unauthorized access"
              deny_access
            end
          #redirect_to root_path if @user.nil?
      else
        authenticate
      end
    end

end
