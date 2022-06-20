class ArticlesController < ApplicationController

  def index
    @articles = Article.all
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
      redirect_to @article, notice: 'Successfully Updated Article'
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
      params.require(:article).permit(:title, :body)
    end
end
