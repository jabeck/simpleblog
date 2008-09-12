class AddCountToCategory < ActiveRecord::Migration
  def self.up
  		add_column :categories, :count, :int
  end

  def self.down
  		remove_column :categories, :count
  end
end
