module Api
  module V1
    class ArticlesController < ApiController
      before_action :authentication, except: [:create]
      
      skip_before_action :verify_authenticity_token

      def index 
        @articles = Article.search(params)
        @articles = @articles.joins(:user)
        # # respond_to do |format| 
        # #   format.html
        # #   format.json
        # # end
        @article = Article.new
        unless @articles.kind_of?(Array)
          @articles = @articles.page(params[:page]).per(5) unless request.format == 'xlsx'  #does pagination if not xlsx format
        else
          @articles = Kaminari.paginate_array(@articles).page(params[:page]).per(5) unless request.format == 'xlsx'
        end

        render json: @articles, status: :ok
      end 

      def show
        @article = Article.find(params[:id])

        render json: @article
      end

      def create
        # @article = CreateArticle::ArticleCreate.new(article_params).create_article
        @article = Article.new(article_params)

        if @article.save
          render json: @article, status: :created
        else
          render json: @article.errors, status: :unprocessable_entity
        end
      end

      def update
        @article = Article.find(params[:id])

        if @article.update(article_params)
          head :no_content
        else
          render json: @article.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @article = Article.find(params[:id])

        if @article.destroy
          render json: { message: 'Article Delete Successfully'}
        else
          render json: @article.errors, status: :unprocessable_entity
        end
      end

      private
      def article_params
        params.require(:article).permit(:id, :user_id, :title, :body, :status)
      end
    end
  end
end