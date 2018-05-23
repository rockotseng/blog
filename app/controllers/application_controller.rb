class ApplicationController < ActionController::Base

  protected

  def verify_resource_ownership
    if params[:id].present?
      @article = Article.find(params[:id])
      not_found if current_author != @article.author
    end
  end

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end
end
