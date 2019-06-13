require 'test_helper'

class LiveControllerTest < ActionDispatch::IntegrationTest
  test "should get live index" do
    get live_url
    assert_response :success
  end
end
