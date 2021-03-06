require "kramdown"

class News < ApplicationRecord
  include NewsHelper

  self.primary_key = "id"

  PAGINATION_STEP = 20.freeze
  DOMAIN_NAME = "http://nbrugby.com".freeze

  CHANNEL_LIST = [
    ['新闻', 0],
    ['比分', 1]
  ].freeze

  STATUS = {
    :ok => 0,
    :deleted => 1,
    :highlighted => 2
  }.freeze

  validates :title, length: {minimum: 2}, presence: true
  validates :channel, numericality: {greater_than_or_equal_to: 0, less_than: CHANNEL_LIST.size}
  validates :event, numericality: {greater_than_or_equal_to: 0, less_than: Events::EVENT_LIST.size}
  validates :status, numericality: {greater_than_or_equal_to: 0, less_than: STATUS.size}

  def markdown_content
    new_content = content
    new_content = balance_score(content) if channel == 1
    Kramdown::Document.new(new_content).to_html
  end

  def page_title
    "#{title} | "
  end

  def channel_event
    if event == 0
      channel_text
    else
      "#{channel_text} | #{event_text}"
    end
  end

  def channel_text
    News::CHANNEL_LIST[channel][0]
  end

  def event_text
    return "" if event == 0
    Events::name(event)
  end

  def url
    "#{DOMAIN_NAME}/news/#{id}"
  end
end
