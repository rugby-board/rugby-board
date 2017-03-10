module NewsHelper
  def send_twitter
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.configuration.twitter["consumer_key"]
      config.consumer_secret     = Rails.configuration.twitter["consumer_secret"]
      config.access_token        = Rails.configuration.twitter["access_token"]
      config.access_token_secret = Rails.configuration.twitter["access_token_secret"]
    end

    client.update("Hello, we here to introduce RugbyNewBoard, to provide rugby news for Chinese people. 你好，这里是 RugbyNewBoard，提供第一手中文英式橄榄球资讯。")
  end
end
