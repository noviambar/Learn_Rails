class ArticlesController < ApplicationController

  before_action :user_signed_in?
  helper_method :current_user

  #menampilkan semua article
  def index
    @articles = Article.search(params)
    @articles = @articles.joins(:user)
    respond_to do |format| 
      format.html
      format.xlsx
      ExportJob.perform_later
    end
    @article = Article.new
    unless @articles.kind_of?(Array)
      @articles = @articles.page(params[:page]).per(3) unless request.format == 'xlsx'  #does pagination if not xlsx format
    else
      @articles = Kaminari.paginate_array(@articles).page(params[:page]).per(3) unless request.format == 'xlsx'
    end
  end
  
  #menampilkan article berdasarkan id
  def show
    @article = Article.find(params[:id])
    
  end
  
  #membuat form tambah article
  def new
    @article = Article.new
    @users = User.pluck(:name, :id)
  end
  
  #membuat article baru
  def create 
    # @article = Article.new(article_params)
    @article = CreateArticle::ArticleCreate.new(article_params).create_article #call method from services

    respond_to do |format|
      if @article.save
        @articles = Article.all
        format.turbo_stream
        format.html {redirect_to root_path(@article), notice: 'Article successfuly created'}
      else
        flash.now[:messages] = @article.errors.full_messages[0]
        format.html{ render :new, status: :unprocessable_entity}
      end
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
    # @comment = Comment.find_by(params[:article_id])
    @article = Article.find(params[:id])
    @article.destroy
  
    redirect_to root_path, status: :see_other, flash: { notice: 'Article Deleted Successfully'}
  end

  #form import file
  def import_items
    # @attachment = Article.new
  end

  #import file
  def import
    # @result = Article.import(params[:attachment], current_user)

    @result = ImportJob.perform_now(params[:attachment], current_user)
    
  
    # debugger
    unless @result == false
      redirect_to root_path, flash: { notice: 'Item imported'}
    else
      redirect_to root_path, flash: { warn: 'Unknown File Type!'}
    end
  end 
  
  private
    def article_params
      params.require(:article).permit(:user_id, :title, :body, :status)
    end
end
