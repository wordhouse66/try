class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]
  before_action :set_category, only: [:show, :edit, :update]

  def index
    @categories = Category.paginate(page: params[:page])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'Category successfully created'
      redirect_to categories_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @category_articles = @category.articles.paginate(page: params[:page])
  end

  def edit

  end

  def update
    if @category.update(category_params) 
      flash[:success] = 'Category successfully updated'
      redirect_to category_url(@category)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !logged_in? || (logged_in? && !current_user.admin?)
      flash[:danger] = 'Only admin users can perform that function'
      redirect_to categories_path
    end
  end
end