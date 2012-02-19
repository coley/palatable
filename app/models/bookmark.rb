class Bookmark < ActiveRecord::Base
  attr_accessible :name, :url, :date_saved
  
  validates :name,  :presence => true,
                    :length => { :maximum => 99}
  
  validates :url, :presence => true,
                  :length => { :minimum => 10 }
end
