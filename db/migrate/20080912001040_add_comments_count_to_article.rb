class AddCommentsCountToArticle < ActiveRecord::Migration
  def self.up
  		add_column :articles, :comments_count, :int
  end

  def self.down
  		remove_column :articles, :comments_count
  end
end
