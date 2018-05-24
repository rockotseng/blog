require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  setup do
    @comment = comments(:one)
  end

  test 'should update comment' do
    assert @comment.update(commenter: 'New commenter', body: 'New body')
  end

  test 'should not update comment without commenter' do
    assert_not @comment.update(commenter: nil)
  end

  test 'should not update comment without body' do
    assert_not @comment.update(body: nil)
  end

  test 'should not update comment if commenter is too short' do
    assert_not @comment.update(commenter: 'abc')
  end

  test 'should not update comment if commenter is too long' do
    commenter = 'Fixtures is a fancy word for sample data. Fixtures allow you
                 to populate your testing database with predefined data before
                 your tests run. Fixtures are not designed to create every
                 object that your tests need, and are best managed when only
                 used for default data that can be applied to the common case.'
    assert_not @comment.update(commenter: commenter)
  end

  test 'should not update comment if body is too short' do
    assert_not @comment.update(body: 'abc')
  end

  test 'should not update comment if body is too long' do
    body = 'For good tests, you\'ll need to give some thought
            to setting up test data. In Rails, you can handle
            this by defining and customizing fixtures.'
    assert_not @comment.update(body: body)
  end

end
