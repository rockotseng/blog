require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    @article = articles(:one)
  end

  teardown do
    Rails.cache.clear
  end

  test 'should list articles' do
    get articles_url
    assert_response :success
  end

  test 'should show new article' do
    sign_in authors(:one)
    get new_article_url
    assert_response :success
  end

  test 'should create article' do
    sign_in authors(:one)
    assert_difference('Article.count') do
      post articles_url, params: { article: { title: 'title', text: 'text' } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test 'should show article' do
    get article_url(@article)
    assert_response :success
  end

  test 'should show edit page' do
    sign_in authors(:one)
    get edit_article_url(@article)
    assert_response :success
  end

  test 'should not show edit page if not author' do
    sign_in authors(:two)
    assert_raises(ActionController::RoutingError) do
      get edit_article_url(@article)
    end
  end

  test 'should update article' do
    sign_in authors(:one)
    title = 'updated'
    patch article_url(@article), params: { article: { title: title } }
    assert_redirected_to article_url(@article)
    @article.reload
    assert_equal title, @article.title
  end

  test 'should not update article if not author' do
    sign_in authors(:two)
    title = 'updated'
    assert_raises(ActionController::RoutingError) do
      patch article_url(@article), params: { article: { title: title } }
    end
  end

  test 'should destroy article' do
    sign_in authors(:one)
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_url
  end

  test 'should not destroy article if not author' do
    sign_in authors(:two)
    assert_raises(ActionController::RoutingError) do
      delete article_url(@article)
    end
  end

end
