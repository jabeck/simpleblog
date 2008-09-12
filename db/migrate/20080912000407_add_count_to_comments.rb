class AddCountToComments < ActiveRecord::Migration
  def self.up
  		add_column :comments, :count, :int
  end

  def self.down
  		remove_column :comments, :count
  end
end
