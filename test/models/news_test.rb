require 'test_helper'

class NewsTest < ActiveSupport::TestCase
  test "should not save news without title" do
    news = News.new
    news.content = ""
    news.channel = 0
    news.event = 0
    news.status = 0
    news.tag = ""

    assert_not news.save
  end

  test "should not save news if title is not long enough" do
    news = News.new
    news.title = "1"
    news.content = ""
    news.channel = 0
    news.event = 0
    news.status = 0
    news.tag = ""

    assert_not news.save
  end

  test "should not save new if channel is not existed" do
    news = News.new
    news.title = "a title"
    news.content = ""
    news.channel = 100
    news.event = 0
    news.status = 0
    news.tag = ""

    assert_not news.save
  end

  test "should not save new if event is not existed" do
    news = News.new
    news.title = "a title"
    news.content = ""
    news.channel = 1
    news.event = 100
    news.status = 0
    news.tag = ""

    assert_not news.save
  end

  test "should not save new if status is not existed" do
    news = News.new
    news.title = "a title"
    news.content = ""
    news.channel = 1
    news.event = 10
    news.status = 10
    news.tag = ""

    assert_not news.save
  end

  test "generate markdown content" do
  	news = News.new
    news.title = "a title"
    news.content = "[aaa](http://rugbynews.space)"
    news.channel = 0
    news.event = 0
    news.status = 0
    news.tag = ""
    news.save

    assert_equal "<p><a href=\"http://rugbynews.space\">aaa</a></p>\n", news.markdown_content
  end
end
