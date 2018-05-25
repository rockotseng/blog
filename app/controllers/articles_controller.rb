class ArticlesController < ApplicationController

  before_action :authenticate_author!, except: [:index, :show]
  before_action :verify_article_ownership, only: [:edit, :update, :destroy]

  # A frequent practice is to place the standard CRUD actions in each controller
  # in the following order: index, show, new, edit, create, update and destroy.
  def index
    @articles = Article.all.page params[:page]
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    # The reason why we added @article = Article.new in the ArticlesController is
    # that otherwise @article would be nil in our view, and calling @article.errors.any?
    # would throw an error.
    @article = Article.new
  end

  def edit
    @article
  end

  def create
    @article = current_author.articles.create(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end

  def verify_article_ownership
    if params[:id].present?
      @article = Article.find(params[:id])
      not_found if current_author != @article.author
    end
  end

end
