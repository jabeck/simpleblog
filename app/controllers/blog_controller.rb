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
  		
  		@categories = Category.find(:all) #This is just a placeholder until I figure out how to display categories separately.
  end
end
