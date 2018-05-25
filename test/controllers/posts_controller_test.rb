require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
  end

  teardown do
    Rails.cache.clear
  end

  test 'should list posts' do
    get posts_url
    assert_response :success
  end

  test 'should show new post' do
    sign_in authors(:one)
    get new_post_url
    assert_response :success
  end

  test 'should create post' do
    sign_in authors(:one)
    assert_difference('Post.count') do
      post posts_url, params: { post: { title: 'title', text: 'text' } }
    end

    assert_redirected_to post_url(Post.last)
  end

  test 'should show post' do
    get post_url(@post)
    assert_response :success
  end

  test 'should show edit page' do
    sign_in authors(:one)
    get edit_post_url(@post)
    assert_response :success
  end

  test 'should not show edit page if not author' do
    sign_in authors(:two)
    assert_raises(ActionController::RoutingError) do
      get edit_post_url(@post)
    end
  end

  test 'should update post' do
    sign_in authors(:one)
    title = 'updated'
    patch post_url(@post), params: { post: { title: title } }
    assert_redirected_to post_url(@post)
    @post.reload
    assert_equal title, @post.title
  end

  test 'should not update post if not author' do
    sign_in authors(:two)
    title = 'updated'
    assert_raises(ActionController::RoutingError) do
      patch post_url(@post), params: { post: { title: title } }
    end
  end

  test 'should destroy post' do
    sign_in authors(:one)
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end

  test 'should not destroy post if not author' do
    sign_in authors(:two)
    assert_raises(ActionController::RoutingError) do
      delete post_url(@post)
    end
  end

end
