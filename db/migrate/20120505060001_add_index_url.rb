class AddIndexUrl < ActiveRecord::Migration
  def self.up
    add_index :bookmarks, :url
  end

  def self.down
    remove_index :bookmarks, :url
  end
end
