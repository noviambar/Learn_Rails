module CreateArticle
  class ArticleCreate
    attr_accessor :title, :body, :user_id, :status
    def initialize(article_params)
      @title = article_params[:title]
      @body = article_params[:body]
      @user_id = article_params[:user_id]
      @status = article_params[:status]
    end

    def create_article
      Article.create!(
        title: title,
        body: body,
        user_id: user_id,
        status: status
      )
    end

    private
    def article_params
      params.permit(:user_id, :title, :body, :status)
    end
  end
end