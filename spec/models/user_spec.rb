require 'spec_helper'

describe User do
 
  before(:each) do
    @attr = {:id => 1, :username => "myusername", :full_name => "Peter Mary",
             :email => "myemail@gmail.com", :password => "mypassword",
             :password_confirmation => "mypassword" }
   end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  it "should require a username" do
   no_username_user = User.new(@attr.merge(:username => ""))
   no_username_user.should_not be_valid
  end
  
  it "should require a full name" do
   no_fullname_user = User.new(@attr.merge(:full_name => ""))
   no_fullname_user.should_not be_valid
  end
  
  it "should reject full names that are too long" do
    long_name = "a" * 76
    long_name_user = User.new(@attr.merge(:full_name => long_name))
    long_name_user.should_not be_valid
  end

  it "should reject full names that are too short" do
    short_name = "a" * 1
    short_name_user = User.new(@attr.merge(:full_name => short_name))
    short_name_user.should_not be_valid
  end

  it "should require an email" do
   no_email_user = User.new(@attr.merge(:email => ""))
   no_email_user.should_not be_valid
  end
  
  it "should require a password" do
   no_password_user = User.new(@attr.merge(:password => ""))
   no_password_user.should_not be_valid
  end
  
  it "should reject passwords that are too long" do
    long_password = "a" * 41
    long_password_user = User.new(@attr.merge(:password => long_password))
    long_password_user.should_not be_valid
  end

  it "should reject passwords that are too short" do
    short_password = "a" * 6
    short_password_user = User.new(@attr.merge(:password => short_password))
    short_password_user.should_not be_valid
  end

  it "should require a confirmation password" do
   no_passwordconfirm_user = User.new(@attr.merge(:password_confirmation => ""))
   no_passwordconfirm_user.should_not be_valid
  end
  
  it "should reject confirmation passwords that are too long" do
    long_passwordconfirm = "a" * 41
    long_passwordconfirm_user = User.new(@attr.merge(:password_confirmation => long_passwordconfirm))
    long_passwordconfirm_user.should_not be_valid
  end

  it "should reject confirmation passwords that are too short" do
    short_passwordconfirm = "a" * 6
    short_passwordconfirm_user = User.new(@attr.merge(:password_confirmation => short_passwordconfirm))
    short_passwordconfirm_user.should_not be_valid
  end
 
end
