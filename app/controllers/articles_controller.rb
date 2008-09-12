class ArticlesController < ApplicationController

	before_filter :authorize, :except => :show
  # GET /articles
  # GET /articles.xml
  def index
    @articles = Article.find(:all, :order => "date")
    @categories = Category.find(:all)
	 
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articles }
    end
  end
  
  def publish
  	@article = Article.find(params[:id])
  	@article.published_status = "Published"
  	@article.update_attributes(params[:article])
  	redirect_to(@article)
  	flash[:notice] = 'Article published.'
  end
  
  def preview
  	@article = Article.find(params[:id])
	@categories = Category.find(:all)
	flash[:notice] = "This is only a preview. Your changes cannot be seen by other users."
	redirect_to(@article)
  end
  
  def comment
  	 @article = Article.find(params[:id])
    @article.comments.create(params[:comment])
    flash[:notice] = "Comment added successfully"
    redirect_to(@article)
  end

  def new_category
  	 redirect_to(categories_path)
  end
  # GET /articles/1
  # GET /articles/1.xml
  def show
    @article = Article.find(params[:id])
    @categories = Category.find(:all)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
  end 
  
  # GET /articles/new
  # GET /articles/new.xml
  def new
    @article = Article.new
	 @categories = Category.find(:all)
	 
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
    @categories = Category.find(:all)
  end

  # POST /articles
  # POST /articles.xml
  def create
    @article = Article.new(params[:article])
    @article.date = Time.now #.strftime("%b %b %Y, %l:%M%P")
    @article.published_status = "Unpublished" if !@article.published_status?
    @categories = Category.find(:all)
    @article.category_id = (params[:category])

    respond_to do |format|
      if @article.save
        flash[:notice] = 'Article was successfully created.'
        format.html { redirect_to(edit_article_path(@article)) }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.xml
  def update
    @article = Article.find(params[:id])
  	 @article.category_id = (params[:category])
      	
    respond_to do |format|
      if @article.update_attributes(params[:article])
        flash[:notice] = 'Article was successfully updated.'
        format.html { redirect_to(edit_article_path(@article)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.xml
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(articles_url) }
      format.xml  { head :ok }
    end
  end
end
