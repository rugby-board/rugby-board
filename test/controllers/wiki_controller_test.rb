require 'test_helper'

class WikiControllerTest < ActionDispatch::IntegrationTest
  test "should get wiki index" do
    get wiki_url
    assert_response :success
  end
end
