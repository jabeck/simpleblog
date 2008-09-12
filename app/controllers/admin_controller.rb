class AdminController < ApplicationController
  def login
  		@categories = Category.find(:all)
  		session[:user_id] = nil
  		if request.post?
  			user = User.authenticate(params[:name], params[:password])
  			if user
  				session[:user_id] = user.id
  				#uri = session[:original_uri]
  				#session[:original_uri] = nil
				flash[:notice] = "Log in successful."
  				redirect_to( :controller => :blog, :action => :index)
  			else
  				flash.now[:notice] = "Invalid user/password combination"
  			end
  		end
  end

  def logout
  		@categories = Category.find(:all)
  		session[:user_id] = nil
  		flash[:notice] = "Logged out"
  		redirect_to(:action => "login")
  end

  def index
  	@categories = Category.find(:all)
  	@articles = Article.find(:all)
  end

end
