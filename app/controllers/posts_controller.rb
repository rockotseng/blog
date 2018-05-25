class PostsController < ApplicationController

  before_action :authenticate_author!, except: [:index, :show]
  before_action :verify_post_ownership, only: [:edit, :update, :destroy]

  # A frequent practice is to place the standard CRUD actions in each controller
  # in the following order: index, show, new, edit, create, update and destroy.
  def index
    @posts = Post.all.page params[:page]
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    # The reason why we added @post = Post.new in the PostsController is
    # that otherwise @post would be nil in our view, and calling @post.errors.any?
    # would throw an error.
    @post = Post.new
  end

  def edit
    @post
  end

  def create
    @post = current_author.posts.create(post_params)

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def verify_post_ownership
    if params[:id].present?
      @post = Post.find(params[:id])
      not_found if current_author != @post.author
    end
  end

end
