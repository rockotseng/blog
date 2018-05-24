require 'test_helper'

class AuthorTest < ActiveSupport::TestCase

  setup do
    @author = authors(:one)
  end

  test 'should delete articles if author is deleted' do
    article = @author.articles.first
    @author.destroy
    assert_nil Article.find_by_id(article.id)
  end

end
