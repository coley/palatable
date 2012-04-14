class SessionsController < ApplicationController
  
  def new
    @title = "sign in"
  end

  def create
    user = User.authenticate(params[:session][:username],
                             params[:session][:password])
    if user.nil?
      # Create an error message and re-render the signin form.
      flash.now[:error] = "invalid username and password combination"
      @title = "sign in"
      render 'new'
    else
      # Sign the user in and redirect to the user's bookmarks page.
      sign_in user
      redirect_to allBookmarks_path
    end
  end

 def destroy
    sign_out
    redirect_to root_path
 end
 
end
