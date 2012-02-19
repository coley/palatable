class Bookmark < ActiveRecord::Base
  validates :name,  :presence => true,
                    :length => { :maximum => 99}
  
  validates :url, :presence => true,
                  :length => { :minimum => 10 }
end
