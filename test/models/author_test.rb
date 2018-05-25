require 'test_helper'

class AuthorTest < ActiveSupport::TestCase

  setup do
    @author = authors(:one)
  end

  test 'should delete posts if author is deleted' do
    post = @author.posts.first
    @author.destroy
    assert_nil Post.find_by_id(post.id)
  end

end
