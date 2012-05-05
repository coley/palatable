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
  
  validates :name,  :presence => true,
                    :length => { :maximum => 99}
  
  validates :url, :presence => true,
                  :length => { :minimum => 10 },
                  :uniqueness => { :case_sensitive => false,
                                   :scope => [:user_id] }
                  
  default_scope :order => 'bookmarks.name ASC'
   
end
