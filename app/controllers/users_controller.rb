class UsersController < ApplicationController
  
  def login
    @title = "login"
  end
  
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
      redirect_to(@user, :notice => 'You are signed up!')
    else
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
