class CommentsController < ApplicationController

  before_action :authenticate_author!, only: [:destroy]
  before_action :verify_article_ownership, only: [:destroy]

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  def destroy
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

  def verify_article_ownership
    if params[:article_id].present?
      @article = Article.find(params[:article_id])
      not_found if current_author != @article.author
    end
  end
end
