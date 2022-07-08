class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comment.create(comment_params)
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:id])
    @comment = Comment.find(params[:article_id])
    @comment.destroy
    
    redirect_to article_path, status: :see_other, flash: { notice: 'The comment has been successfully deleted' }
  end

  private
    def comment_params
      params.require(:comment).permit(:id, :commenter, :body, :article_id)
    end
end
