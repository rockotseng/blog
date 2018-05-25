require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
  end

  teardown do
    Rails.cache.clear
  end

  test 'should create comment' do
    assert_difference('Comment.count') do
      post post_comments_path(post_id: @post.id), params: { comment: { commenter: 'commenter', body: 'body' } }
    end

    assert_redirected_to @post
  end

  test 'should destroy comment' do
    sign_in authors(:one)
    assert_difference('Comment.count', -1) do
      delete post_comment_path(post_id: @post.id, id: @post.comments.first.id)
    end

    assert_redirected_to @post
  end

  test 'should not destroy comment if not author' do
    sign_in authors(:two)
    assert_raises(ActionController::RoutingError) do
      delete post_comment_path(post_id: @post.id, id: @post.comments.first.id)
    end
  end
end
