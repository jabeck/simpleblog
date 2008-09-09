#This part I got help with from http://www.sapphiresteel.com/How-To-Create-A-Ruby-On-Rails-Blog,168
class Comment < ActiveRecord::Base
	belongs_to :article
end