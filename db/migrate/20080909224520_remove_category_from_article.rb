class RemoveCategoryFromArticle < ActiveRecord::Migration
  def self.up
  	remove_column :articles, :category
  end

  def self.down
  end
end
