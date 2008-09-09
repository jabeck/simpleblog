class Category < ActiveRecord::Base
	has_many :articles
	validates_presence_of :category_name
	validates_uniqueness_of :category_name
end