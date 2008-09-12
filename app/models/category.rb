class Category < ActiveRecord::Base
	has_many :articles
	validates_presence_of :category_name
	validates_uniqueness_of :category_name
	
	def get_count
		@articles = Article.find(:all, :conditions => ["category_id = ?", self.id])
		@published_articles = []
		
		for article in @articles
			if article.published_status == "Published"
				@published_articles << article
			end
		end
		
		self.count = @published_articles.length
	end
end