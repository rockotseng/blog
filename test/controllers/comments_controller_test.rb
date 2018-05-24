require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    @article = articles(:one)
  end

  teardown do
    Rails.cache.clear
  end

  test 'should create comment' do
    assert_difference('Comment.count') do
      post article_comments_path(article_id: @article.id), params: { comment: { commenter: 'commenter', body: 'body' } }
    end

    assert_redirected_to @article
  end

  test 'should destroy comment' do
    sign_in authors(:one)
    assert_difference('Comment.count', -1) do
      delete article_comment_path(article_id: @article.id, id: @article.comments.first.id)
    end

    assert_redirected_to @article
  end

  test 'should not destroy comment if not author' do
    sign_in authors(:two)
    assert_raises(ActionController::RoutingError) do
      delete article_comment_path(article_id: @article.id, id: @article.comments.first.id)
    end
  end
end
