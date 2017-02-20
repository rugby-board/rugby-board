require 'test_helper'

class NewsTest < ActiveSupport::TestCase
  test "should not save news without title" do
    news = News.new
    assert_not news.save
  end

  test "should not save news if title is not long enough" do
    news = News.new
    news.title = "1"
    assert_not news.save
  end
end
