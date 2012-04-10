class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :show]
    
  def dashboard
    @title = "dashboard"
  end

  def show
    @title = "view profile"
    @user = User.find(params[:id])
  end

  def new
    @title = "sign up"
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if (@user.save)
      sign_in @user
      flash[:success] = "Welcome to Pal.atab.le!"
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
        flash[:success] = "Profile was successfully updated."
        redirect_to @user
    else
        @title = "update profile"
        render 'edit' 
    end
  end

 private

    def authenticate
      deny_access unless signed_in?
    end
end
