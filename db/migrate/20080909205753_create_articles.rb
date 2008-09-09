class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.string :date
      t.string :author
      t.string :category
      t.string :published_status

      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
