class BlogController < ApplicationController
  def index
  		@articles = Article.find_articles
  		
  		if @articles.length < 5
  			@recent_articles = @articles.slice(1..@articles.length)
		else
  			@recent_articles = @articles.slice(1..5)
  		end

  		if !@articles.empty?
  			@latest_article = @articles.fetch(0)
  		end
  		
  		@categories = Category.find(:all)
  end
  
  protected
  	def authorize
  	end
end
