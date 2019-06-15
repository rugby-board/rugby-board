class News < ApplicationRecord
  self.primary_key = "id"

  PAGINATION_STEP = 20.freeze
  DOMAIN_NAME = "http://nbrugby.com".freeze

  CHANNEL_LIST = [
    ['新闻', 0],
    ['比分', 1]
  ].freeze

  EVENT_LIST = [
    ['无', 0],
    ['国际测试赛', 1],
    ['Six Nations', 2],
    ['Rugby Championship', 3],
    ['Super Rugby', 4],
    ['Premiership', 5],
    ['TOP 14', 6],
    ['PRO 14', 7],
    ['European Champions Cup', 8],
    ['Rugby World Cup', 9],
    ['British and Irish Lions', 10],
    ['European Challenge Cup', 11],
    ['Currie Cup', 12],
    ['Top League', 13],
    ['Rugby Sevens', 14],
    ['Women\'s Rugby', 15],
    ['Barbarians', 16],
    ['Anglo Welsh Cup', 17],
    ['Mitre 10 Cup', 18],
    ['National Rugby Championship', 19],
    ['Major League Rugby', 20]
  ].freeze

  EVENT_NAME_ID_MAP = {
    'international-tests': 1,
    'six-nations': 2,
    'rugby-championship': 3,
    'super-rugby': 4,
    'premiership': 5,
    'top14': 6,
    'pro14': 7,
    'european-champions-cup': 8,
    'rugby-world-cup': 9,
    'british-and-irish-lions': 10,
    'european-challenge-cup': 11,
    'currie-cup': 12,
    'top-league': 13,
    'rugby-sevens': 14,
    'womens-rugby': 15,
    'barbarians': 16,
    'anglo-welsh-cup': 17,
    'mitre-10-cup': 18,
    'national-rugby-championship': 19,
    'major-league-rugby': 20,
  }

  EVENT_NAME_MAP = {
    'international-tests': '国际测试赛',
    'six-nations': '六国赛 Six Nations',
    'rugby-championship': '冠军赛 The Rugby Championship',
    'rugby-world-cup': '橄榄球世界杯',
    'british-and-irish-lions': '不列颠和爱尔兰狮子 British & Irish Lions',
    'barbarians': '野蛮人',
    'rugby-sevens': '7人制橄榄球',
    'womens-rugby': '女子橄榄球',

    'super-rugby': '超级橄榄球 Super Rugby',
    'premiership': '英格兰超级联赛 Premiership',
    'top14': '法国 Top 14 联赛',
    'pro14': 'PRO14 联赛',
    'european-challenge-cup': '欧洲挑战杯',
    'european-champions-cup': '欧洲冠军杯',

    'currie-cup': '库里杯 Currie Cup',
    'top-league': '日本 Top League 联赛',
    'mitre-10-cup': 'Mitre 10 杯',
    'national-rugby-championship': '国家橄榄球冠军赛',
    'major-league-rugby': '职业橄榄球大联盟',
    'anglo-welsh-cup': '盎格鲁威尔士杯',
  }

  WIKI_AVAILABILITY = {
    'six-nations': true,
    'rugby-championship': true,
    'rugby-world-cup': true,
    'british-and-irish-lions': true,
    'super-rugby': true,
    'premiership': true,
    'top14': true,
    'pro14': true,
    'currie-cup': true,
    'top-league': true,
    'mitre-10-cup': true,
    'major-league-rugby': true,
    'anglo-welsh-cup': true,
  }

  STATUS = {
    :ok => 0,
    :deleted => 1,
    :highlighted => 2
  }.freeze

  validates :title, length: {minimum: 2}, presence: true
  validates :channel, numericality: {greater_than_or_equal_to: 0, less_than: CHANNEL_LIST.size}
  validates :event, numericality: {greater_than_or_equal_to: 0, less_than: EVENT_LIST.size}
  validates :status, numericality: {greater_than_or_equal_to: 0, less_than: STATUS.size}

  def markdown_content
    require "kramdown"
    Kramdown::Document.new(content).to_html
  end

  def page_title
    "#{title} | "
  end

  def url
    "#{DOMAIN_NAME}/news/#{id}"
  end
end
