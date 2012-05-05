# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  username           :string(255)
#  full_name          :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#


class User < ActiveRecord::Base

  has_many :bookmarks, :dependent => :destroy

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  attr_accessor :password, :updating_password
  attr_accessible :username, :full_name, :email, :password, :password_confirmation
  
  validates :username,  :presence => true,
                        :uniqueness => { :case_sensitive => false },
                        :length     => { :within => 5..20 }
  
  validates :full_name, :presence => true,
                        :length => { :within => 2..75 }
                        
  validates :email,     :presence => true,
                        :format   => { :with => email_regex },
                        :length   => { :within => 2..200 },
                        :uniqueness => { :case_sensitive => false }
  
  validates :password,  :confirmation => true
  validates :password,  :presence => true, :if => :should_validate_password?
  validates :password,  :length => { :within => 7..40 }, :if => :should_validate_password?
                        
  validates :password_confirmation,  :presence => true, :if => :should_validate_password?
  validates :password_confirmation,  :length => { :within => 7..40 }, :if => :should_validate_password?
                                       
  before_save :encrypt_password, :unless => "password.blank?"

  #Only updates password on user creation or if updating_password is set to true in controller
  def should_validate_password?
      updating_password || new_record?
  end
  
  #Only requires current password for update
  def should_get_current_password?
      updating_password
  end
    
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
