class News < ApplicationRecord

  PAGINATION_STEP = 20.freeze
  
  CHANNEL_LIST = [
    ['新闻', 0],
    ['赛事', 1],
  ].freeze

  EVENT_LIST = [
    ['无', 0],
    ['Test Matches', 1],
    ['Six Nations', 2],
    ['Rugby Championship', 3],
    ['Super Rugby', 4],
    ['Premiership', 5],
    ['TOP 14', 6],
    ['PRO 12', 7],
    ['European Champions Cup', 8],
    ['Rugby World Cup', 9],
    ['British and Irish Lions', 10],
    ['European Challenge Cup', 11],
    ['Currie Cup', 12],
    ['Top League', 13],
    ['Rugby Sevens', 14]
  ].freeze

  STATUS = {
    :ok => 0,
    :deleted => 1,
    :highlighted => 2
  }.freeze

  validates :title, length: {minimum: 2}, presence: true

  def markdown_content
    require "kramdown"
    Kramdown::Document.new(content).to_html
  end

  def page_title
    "#{title} | "
  end
end
