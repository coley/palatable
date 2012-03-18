class User < ActiveRecord::Base

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  #attr_accessor :password
  attr_accessible :username, :full_name, :email, :password, :password_confirmation
  
  validates :username,  :presence => true,
                        :uniqueness => true
  
  validates :full_name, :presence => true,
                        :length => { :within => 2..75 }
                        
  validates :email,     :presence => true,
                        :format   => { :with => email_regex }
  
  validates :password,  :presence => true,
                        :confirmation => true,
                        :length => { :within => 7..40 }
                        
  validates :password_confirmation,  :presence => true,
                                     :length => { :within => 7..40 }

end
