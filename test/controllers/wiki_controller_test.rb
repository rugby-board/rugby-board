require 'test_helper'

class WikiControllerTest < ActionDispatch::IntegrationTest
  test "should get wiki index" do
    get wiki_url
    assert_response :success
  end

  test "should get wiki of event" do
    get "/wiki/six-nations"
    assert_response :success
  end

  test "should not go for unknown event" do
    get "/wiki/gopro"
    assert_response :found
  end
end
