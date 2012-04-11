require 'spec_helper'

describe "Users" do

  describe "signup" do

    describe "failure" do

      it "should not make a new user" do
        visit signup_path
        fill_in "Username",         :with => ""
        fill_in "Full name",        :with => ""
        fill_in "Email",            :with => ""
        fill_in "Password",         :with => ""
        fill_in "Confirm Password", :with => ""
        click_button
        response.should render_template('users/new')
        response.should have_selector("div.error_explanation")
      end
    end
    
    describe "success" do

      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in "Username",         :with => "myfunusername"
          fill_in "Full name",        :with => "Fun User"
          fill_in "Email",            :with => "myemail@email.com"
          fill_in "Password",         :with => "mypassword"
          fill_in "Confirm Password", :with => "mypassword"
          click_button
          response.should have_selector("p",
                                        :content => "welcome to pal.atab.le")
          response.should render_template('bookmarks')
        end.should change(User, :count).by(1)
      end
    end
  end
  
    describe "sign in/out" do

    describe "failure" do
      it "should not sign a user in" do
        visit signin_path
        fill_in :username, :with => ""
        fill_in :password, :with => ""
        click_button
        response.should have_selector("p", :content => "invalid username and password combination")
      end
    end

    describe "success" do
      it "should sign a user in and out" do
        user = Factory(:user)
        visit signin_path
        fill_in :username, :with => user.username
        fill_in :password, :with => user.password
        click_button
        controller.should be_signed_in
        click_link "sign out"
        controller.should_not be_signed_in
      end
    end
  end
end
