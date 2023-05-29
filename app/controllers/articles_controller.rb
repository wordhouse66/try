class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = 'Article successfully created'
      redirect_to article_path(@article)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @article = @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to article_url(@article), notice: 'Article successfully updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = 'Article successfully destroyed'
    redirect_to articles_url
  end

  private
  def article_params
    params.require(:article).permit(:title, :description)
  end
end