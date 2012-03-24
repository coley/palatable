require 'spec_helper'

describe User do
 
 #user create
 #------------------------------------
 describe "create" do
    before(:each) do
        @attr = {:id => 1, :username => "myusername",
            :full_name => "Peter Mary",
            :email => "myemail@gmail.com",
            :password => "mypassword",
            :password_confirmation => "mypassword" }
    end
    
    it "should create a new instance given valid attributes" do
      User.create!(@attr)
    end    
 end
 
 #user save
 #------------------------------------
  it "should save user when user is valid" do
      User.new(:id => 1, :username => "myusername",
            :full_name => "Peter Mary",
            :email => "myemail@gmail.com",
            :password => "mypassword",
            :password_confirmation => "mypassword").save.should == true
  end    
  
 #factory tests
 #------------------------------------
  it "should have valid factory" do
    Factory.build(:user).should be_valid
  end
  
  #username tests
  #---------------------------------
  it "should require a username" do
    Factory.build(:user, :username => "").should_not be_valid
  end
  
  it "should reject a non-unique username" do
    aUser = Factory.build(:user) 
    existing_user = Factory.create(:user)
    aUser.username = existing_user.username
    aUser.should_not be_valid
  end
  
  it "should accept a valid username" do
    valid_username = "myusername"
    Factory.build(:user, :username => valid_username).should be_valid
  end

  #full_name tests
  #---------------------------------
  it "should require a full name" do
    Factory.build(:user, :full_name => "").should_not be_valid
  end
  
  it "should reject full names that are too long" do
    long_name = "a" * 76
    Factory.build(:user, :full_name => long_name).should_not be_valid
  end
  
  it "should reject full names that are too short" do
    short_name = "a" * 1
    Factory.build(:user, :full_name => short_name).should_not be_valid
  end

  it "should accept a valid full name" do
    valid_fullname = "my full name"
    Factory.build(:user, :full_name => valid_fullname).should be_valid
  end

  #email tests
  #---------------------------------
  it "should require an email" do
    Factory.build(:user, :email => "").should_not be_valid
  end

  it "should reject missing local-part" do
    invalid_email = "@gmail.com"
    Factory.build(:user, :email => invalid_email).should_not be_valid
  end

  it "should reject missing @" do
    invalid_email = "myname.gmail.com"
    Factory.build(:user, :email => invalid_email).should_not be_valid
  end

  it "should reject missing domain" do
    invalid_email = "myname@"
    Factory.build(:user, :email => invalid_email).should_not be_valid
  end
  
  it "should reject missing domain extension" do
    invalid_email = "myname@gmail"
    Factory.build(:user, :email => invalid_email ).should_not be_valid
  end

  it "should reject invalid characters" do
    invalid_email = "my name@gmail.com"
    Factory.build(:user, :email => invalid_email).should_not be_valid
  end

  it "should accept a valid email format" do
    valid_email = "myemail@gmail.com"
    Factory.build(:user, :username => valid_email).should be_valid
  end

  #password tests
  #---------------------------------
  it "should require a password" do
    Factory.build(:user, :password => "").should_not be_valid
  end

  it "should reject passwords that are too long" do
    long_password = "a" * 41
    Factory.build(:user, :password => long_password, :password_confirmation => long_password).should_not be_valid
  end

  it "should reject passwords that are too short" do
    short_password = "a" * 6
    Factory.build(:user, :password => short_password, :password_confirmation => short_password).should_not be_valid
  end

  it "should reject a valid password format without a matching confirmation" do
    valid_password = "a" * 7
    Factory.build(:user, :password => valid_password).should_not be_valid
  end

  it "should accept a valid password format with matching confirmation" do
    valid_password = "a" * 7
    Factory.build(:user, :password => valid_password, :password_confirmation => valid_password).should be_valid
  end

  #confirm password tests
  #---------------------------------
  it "should require a confirmation password" do
    Factory.build(:user, :password_confirmation => "").should_not be_valid
  end
  
  it "should reject confirmation passwords that are too long" do
    long_passwordconfirm = "a" * 41
    Factory.build(:user, :password_confirmation => long_passwordconfirm, :password => long_passwordconfirm).should_not be_valid
  end

  it "should reject confirmation passwords that are too short" do
    short_passwordconfirm = "a" * 6
    Factory.build(:user, :password_confirmation => short_passwordconfirm, :password => short_passwordconfirm).should_not be_valid
  end

  it "should reject a valid confirm password format without a matching password" do
    valid_password = "a" * 7
    Factory.build(:user, :password_confirmation => valid_password).should_not be_valid
  end

  it "should accept a valid password confirmation format with matching password" do
    valid_password = "a" * 7
    Factory.build(:user, :password => valid_password, :password_confirmation => valid_password).should be_valid
  end

end
