# == Schema Information
#
# Table name: bookmarks
#
#  id         :integer         not null, primary key
#  url        :string(255)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#


class Bookmark < ActiveRecord::Base
  
  belongs_to :user
  
  attr_accessible :name, :url
  
  url_regex = /^(http:\/\/|https:\/\/|www.)[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  
  validates :name,  :presence => true,
                    :length     => { :within => 3..99 }
  
  validates :url, :presence   => true,
                  :length     => { :within => 10..130 },
                  :uniqueness => { :case_sensitive => false,
                                   :scope => [:user_id] },
                  :format     => { :with => url_regex }
                  
  default_scope :order => 'bookmarks.name ASC'
    
   
end
