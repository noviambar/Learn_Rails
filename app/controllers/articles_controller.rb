class ArticlesController < ApplicationController

  before_action :user_signed_in?
  helper_method :current_user

  #menampilkan semua article
  def index
      @articles = Article.search(params)
  end
  
  #menampilkan article berdasarkan id
  def show
    @article = Article.find(params[:id])
  end
  
  #membuat form tambah article
  def new
    @article = Article.new
  end
  
  #membuat article baru
  def create 
    @article = Article.new(article_params)
  
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  #membuat form update article
  def edit
    @article = Article.find(params[:id])
  end
  
  #update article
  def update
    @article = Article.find(params[:id])
    
    if @article.update(article_params)
      redirect_to @article, flash: { notice: 'Successfully Updated Article' }
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  #hapus article
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
  
    redirect_to root_path, status: :see_other
  end
  
  private
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end
end
