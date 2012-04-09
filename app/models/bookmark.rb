# == Schema Information
#
# Table name: bookmarks
#
#  id         :integer         not null, primary key
#  url        :string(255)
#  name       :string(255)
#  date_saved :datetime
#  created_at :datetime
#  updated_at :datetime
#

class Bookmark < ActiveRecord::Base
  attr_accessible :name, :url, :date_saved
  
  validates :name,  :presence => true,
                    :length => { :maximum => 99}
  
  validates :url, :presence => true,
                  :length => { :minimum => 10 }
end
