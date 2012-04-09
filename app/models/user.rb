# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  username           :string(255)
#  full_name          :string(255)
#  email              :string(255)
#  password           :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#


class User < ActiveRecord::Base

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  attr_accessor :password
  attr_accessible :username, :full_name, :email, :password, :password_confirmation
  
  validates :username,  :presence => true,
                        :uniqueness => { :case_sensitive => false }
  
  validates :full_name, :presence => true,
                        :length => { :within => 2..75 }
                        
  validates :email,     :presence => true,
                        :format   => { :with => email_regex }
  
  validates :password,  :presence => true,
                        :confirmation => true,
                        :length => { :within => 7..40 }
                        
  validates :password_confirmation,  :presence => true,
                                     :length => { :within => 7..40 }
                                     
  before_save :encrypt_password
  
  # Return true if the user's password matches the submitted password.
  def has_password?(submitted_password)
    # Compare encrypted_password with the encrypted version of
    # submitted_password.
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(username, submitted_password)
    user = find_by_username(username)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  private

    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
