require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  setup do
    @article = articles(:one)
  end

  test 'should update article' do
    assert @article.update(title: 'New Title', text: 'New Text')
  end

  test 'should not update article without title' do
    assert_not @article.update(title: nil)
  end

  test 'should not update article if title is too short' do
    assert_not @article.update(title: 'abc')
  end

  test 'should not update article if title is too long' do
    title = 'This helper validates the length of the attributes.'
    assert_not @article.update(title: title)
  end

  test 'should not update article without text' do
    assert_not @article.update(text: nil)
  end

  test 'should not update article if text is too long' do
    text = 'The default error messages depend on the type of length
            validation being performed. You can personalize these
            messages using the :wrong_length, :too_long, and :too_short
            options and \%\{count\} as a placeholder for the number
            corresponding to the length constraint being used. You can
            still use the :message option to specify an error message.'
    assert_not @article.update(text: text)
  end

  test 'should not update article without author' do
    assert_not @article.update(author: nil)
  end

  test 'should delete comments when article is deleted' do
    comment = @article.comments.first
    @article.destroy
    assert_nil Comment.find_by_id(comment.id)
  end

end
