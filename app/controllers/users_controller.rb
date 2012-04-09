class UsersController < ApplicationController
    
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
        redirect_to(@user, :notice => 'User was successfully updated.')
    else
        render :action => "edit" 
    end
  end

end
