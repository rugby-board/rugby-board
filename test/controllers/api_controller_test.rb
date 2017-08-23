require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "should not query without token" do
    get '/api/v1/news/1'
    result = JSON.parse(@response.body)
    assert_equal -1, result["status"]
    assert_equal "Access denied", result["message"]
  end

  test "should get news item" do
    get '/api/v1/news/1', params: {token: "12ffbb6"}
    result = JSON.parse(@response.body)
    assert_equal 1, result["news"]["id"]
    assert_equal 0, result["news"]["status"]
    assert_equal "英格兰保持28人阵容迎战意大利", result["news"]["title"]
    assert_equal "英格兰2月19日晚在彭尼西尔公园 Pennyhill Park 集结，为周日在特维克纳姆球场举行的六国赛对阵意大利的比赛进行训练。",
      result["news"]["content"]
    assert_equal 0, result["news"]["channel"]
    assert_equal "新闻", result["news"]["channel_text"]
    assert_equal 2, result["news"]["event"]
    assert_equal "Six Nations", result["news"]["event_text"]
  end

  test "should get home" do
    get '/api/v1/index', params: {token: "12ffbb6"}
    result = JSON.parse(@response.body)
    assert_not_empty result["highlight"]
    assert_not_empty result["news"]
    assert_not_empty result["results"]
  end

  test "should get default list" do
    get '/api/v1/list', params: {token: "12ffbb6"}
    result = JSON.parse(@response.body)
    assert_not_empty result["news"]
  end

  test "should get channel list" do
    get '/api/v1/list', params: {token: "12ffbb6", channel: 1}
    result = JSON.parse(@response.body)
    assert_not_empty result["news"]
    assert_equal 20, result["news"].size
    result["news"].each do |item|
      assert_equal 1, item["channel"]
    end
  end

  test "should get event list" do
    get '/api/v1/list', params: {token: "12ffbb6", event: 2}
    result = JSON.parse(@response.body)
    assert_not_empty result["news"]
    assert_equal 2, result["news"].size
    result["news"].each do |item|
      assert_equal 2, item["event"]
    end
  end

  test "set highlight" do
    post '/api/v1/news/highlight/1', params: {token: "12ffbb6"}
    result = JSON.parse(@response.body)
    assert_equal 0, result["status"]
  end

  test "unset highlight" do
    post '/api/v1/news/unhighlight/1', params: {token: "12ffbb6"}
    result = JSON.parse(@response.body)
    assert_equal 0, result["status"]
  end

  test "delete news" do
    delete '/api/v1/news/1', params: {token: "12ffbb6"}
    result = JSON.parse(@response.body)
    assert_equal 0, result["status"]
  end

  test "create news" do
    post '/api/v1/news', params: {token: "12ffbb6",
      title: "create news title",
      content: "create news content",
      channel: 0,
      event: 0
    }
    result = JSON.parse(@response.body)
    assert_equal 0, result["status"]
    assert_equal "create news title", result["news"]["title"]
    assert_equal "create news content", result["news"]["content"]
    assert_equal 0, result["news"]["status"]
    assert_equal 0, result["news"]["channel"]
    assert_equal 0, result["news"]["event"]
  end

  test "update news" do
    put '/api/v1/news/1', params: {token: "12ffbb6",
      title: "change news title",
      content: "change news content",
      channel: 1,
      event: 1,
    }
    result = JSON.parse(@response.body)
    assert_equal "change news title", result["news"]["title"]
    assert_equal "change news content", result["news"]["content"]
    assert_equal 1, result["news"]["channel"]
    assert_equal 1, result["news"]["event"]
  end

  test "translate word" do
    get '/api/v1/dict', params: {token: "12ffbb6", entry: "Pau"}
    result = JSON.parse(@response.body)
    assert_equal "波城", result["result"][0]
  end

  test "search news" do
    get '/api/v1/search', params: {token: "12ffbb6", title: 1}
    result = JSON.parse(@response.body)
    assert_not_empty result["news"]
    assert_equal 27, result["page"]["total"]
  end
end
