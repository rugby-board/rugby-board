require 'test_helper'

class NewsAdminTest < ActionDispatch::IntegrationTest
  test "enter admin page" do
    get "/admin?token=12ffbb6"
    assert_response :success
  end

  test "fail enter admin page" do
    get "/admin?token=ffff"
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "div#flash-message", "No permission as an admin."
  end

  test "post a news" do
    post "/news/create",
      params: { 
        news: {
          title: "A new news",
          content: "- i am markdown\n- i am markdown, too",
          tag: ""
        },
        channel: 0,
        event: 3,
        token: "12ffbb6"
      }

    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "div#flash-message", "Create news successfully."
  end

  test "set highlight a news" do
  	post "/news/highlight",
      params: { 
        news: {
          id: 1
        },
        "set-highlight": "",
        token: "12ffbb6"
      }

    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "div#flash-message", "Highlight news 1 set successfully."
    assert_select "div.section-headline", "英格兰保持28人阵容迎战意大利"
  end

  test "cancel highlight a news" do
    post "/news/highlight",
      params: { 
        news: {
          id: 1
        },
        "cancel-highlight": "",
        token: "12ffbb6"
      }

    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "div#flash-message", "Highlight news 1 cancelled successfully."
    assert_select "div.section-headline", 1
  end

  test "edit a news" do
    post "/news/edit",
      params: { 
        news: {
          id: 2,
          title: "PRO12 联赛比分汇总",
          content: "a new content",
          tag: "PRO12"
        },
        channel: 1,
        event: 7,
        token: "12ffbb6"
      }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "div#flash-message", "Edit news 2 successfully."

    get "/news/2"
    assert_response :success
    assert_select "div#news-2 div.section-content", "a new content"
  end

  test "delete a news" do
    delete "/news/delete",
      params: {
        news: {
          id: 4
        },
        token: "12ffbb6"
      }

    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "div#flash-message", "Delete news 4 successfully."
    assert_select "div#news-4", 0
  end
end
