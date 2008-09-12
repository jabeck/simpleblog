class Article < ActiveRecord::Base
	validates_presence_of :title
	has_many :comments
	belongs_to :category
	
	PUBLISHED_STATUS = [
		["Unpublished", "Unpublished"],
		["Published",		"Published"]
	]
		
	def self.find_articles
		find(:all, :conditions => [ "published_status = ?", "Published" ], :order => "date").reverse!
	end
		
	def check_if_published
		if self.published_status == "Published"
			@p_status = "Yes"
		end
	
		if self.published_status == "Unpublished"
			@p_status = "No"
		end
		
		return @p_status		
	end
	
	def publish
		self.published_status = "Published"
	end
	
	def get_count
		@comments = Comment.find(:all, :conditions => [ "article_id = ?", self.id ])
		self.comments_count = @comments.length
	end
	
	def get_author_name
		@user = User.find(:first, :conditions => [ "id = ?", self.author ])
		return @user.name
	end
	
# This section of code, time_ago_or_time_stamp, is from www.almosteffortless.com//2007/07/29/the-perfect-timestamp/	. I've modified it slightly to better fit my app. 
	def time_ago_or_time_stamp
		from_time = self.date
		to_time = Time.now
		detail = false
  		from_time = from_time.to_time if from_time.respond_to?(:to_time)
  		to_time = to_time.to_time if to_time.respond_to?(:to_time)
  		distance_in_minutes = (((to_time - from_time).abs)/60).round
  		distance_in_seconds = ((to_time - from_time).abs).round
  		case distance_in_minutes
    		when 0..1           then time = (distance_in_seconds < 60) ? "#{distance_in_seconds} ago" : '1 minute ago'
    		when 2..59          then time = "#{distance_in_minutes} minutes ago"
    		when 60..90         then time = "1 hour ago"
    		when 90..1440       then time = "#{(distance_in_minutes.to_f / 60.0).round} hours ago"
    		when 1440..2160     then time = '1 day ago' # 1-1.5 days
    		when 2160..2880     then time = "#{(distance_in_minutes.to_f / 1440.0).round} days ago" # 1.5-2 days
    		else time = from_time.strftime("%b %d %Y")
  		end
  		return time_stamp(from_time) if (detail && distance_in_minutes > 2880)
  		return time
	end
	
	def time_stamp(time)
  		time.to_datetime.strftime("%b %b %Y, %l:%M%P").squeeze(' ')
	end
end
