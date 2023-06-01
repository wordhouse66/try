class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]
  before_action :set_user, only: %i[ create]


  def index
    @articles = Article.all
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = @user.articles.new(article_params)
    if @article.save
      flash[:success] = 'Article successfully created'
      redirect_to article_path(@article)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @article.update(article_params) 
      flash[:success] = 'Article successfully updated'
      redirect_to article_url(@article)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    flash[:danger] = 'Article successfully destroyed'
    redirect_to articles_url
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def set_user
    @user = User.first#User.find(params[:user_id])
  end

  def article_params
    params.require(:article).permit(:title, :description, :user_id)
  end
end