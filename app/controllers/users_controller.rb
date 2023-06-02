class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Alpha Bog #{@user.username}"
      redirect_to articles_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'Your account was successfully updated'
      redirect_to articles_url
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end