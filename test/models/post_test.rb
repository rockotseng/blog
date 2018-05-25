require 'test_helper'

class PostTest < ActiveSupport::TestCase

  setup do
    @post = posts(:one)
  end

  test 'should update post' do
    assert @post.update(title: 'New Title', text: 'New Text')
  end

  test 'should not update post without title' do
    assert_not @post.update(title: nil)
  end

  test 'should not update post if title is too short' do
    assert_not @post.update(title: 'abc')
  end

  test 'should not update post if title is too long' do
    title = 'This helper validates the length of the attributes.'
    assert_not @post.update(title: title)
  end

  test 'should not update post without text' do
    assert_not @post.update(text: nil)
  end

  test 'should not update post if text is too long' do
    text = 'The default error messages depend on the type of length
            validation being performed. You can personalize these
            messages using the :wrong_length, :too_long, and :too_short
            options and \%\{count\} as a placeholder for the number
            corresponding to the length constraint being used. You can
            still use the :message option to specify an error message.'
    assert_not @post.update(text: text)
  end

  test 'should not update post without author' do
    assert_not @post.update(author: nil)
  end

  test 'should delete comments when post is deleted' do
    comment = @post.comments.first
    @post.destroy
    assert_nil Comment.find_by_id(comment.id)
  end

end
