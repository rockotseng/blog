class CommentsController < ApplicationController

  before_action :authenticate_author!, only: [:destroy]
  before_action :verify_post_ownership, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    if @comment.errors.any?
      render 'posts/show'
    else
      redirect_to @post
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to @post
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

  def verify_post_ownership
    if params[:post_id].present?
      @post = Post.find(params[:post_id])
      not_found if current_author != @post.author
    end
  end
end
