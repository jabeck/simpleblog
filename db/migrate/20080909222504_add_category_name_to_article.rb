class AddCategoryNameToArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :category_name, :string
  end

  def self.down
    remove_column :articles, :category_name
  end
end
