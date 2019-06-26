class Events
  EVENT_LIST = [
    {
      id: 0,
      key: 'other',
      name: 'Other',
      event_name: '其它',
    },
    {
      id: 1,
      key: 'international-tests',
      name: 'International Tests',
      event_name: '国际测试赛',
    },
    {
      id: 2,
      key: 'six-nations',
      name: 'Six Nations',
      event_name: '六国赛 Six Nations',
      wiki: true,
    },
    {
      id: 3,
      key: 'rugby-championship',
      name: 'Rugby Championship',
      event_name: '冠军赛 The Rugby Championship',
      wiki: true,
    },
    {
      id: 4,
      key: 'super-rugby',
      name: 'Super Rugby',
      event_name: '超级橄榄球 Super Rugby',
      wiki: true,
    },
    {
      id: 5,
      key: 'premiership',
      name: 'Premiership',
      event_name: '英格兰超级联赛 Premiership',
      wiki: true,
    },
    {
      id: 6,
      key: 'top14',
      name: 'TOP 14',
      event_name: '法国 Top 14 联赛',
      wiki: true,
    },
    {
      id: 7,
      key: 'pro14',
      name: 'PRO 14',
      event_name: 'PRO14 联赛',
      wiki: true,
    },
    {
      id: 8,
      key: 'european-champions-cup',
      name: 'European Champions Cup',
      event_name: '欧洲冠军杯',
    },
    {
      id: 9,
      key: 'rugby-world-cup',
      name: 'Rugby World Cup',
      event_name: '橄榄球世界杯',
      wiki: true,
    },
    {
      id: 10,
      key: 'british-and-irish-lions',
      name: 'British and Irish Lions',
      event_name: '不列颠和爱尔兰狮子 British & Irish Lions',
      wiki: true,
    },
    {
      id: 11,
      key: 'european-challenge-cup',
      name: 'European Challenge Cup',
      event_name: '欧洲挑战杯',
    },
    {
      id: 12,
      key: 'currie-cup',
      name: 'Currie Cup',
      event_name: '库里杯 Currie Cup',
      wiki: true,
    },
    {
      id: 13,
      key: 'top-league',
      name: 'Top League',
      event_name: '日本 Top League 联赛',
      wiki: true,
    },
    {
      id: 14,
      key: 'rugby-sevens',
      name: 'Rugby Sevens',
      event_name: '7人制橄榄球',
    },
    {
      id: 15,
      key: 'womens-rugby',
      name: 'Women\'s Rugby',
      event_name: '女子橄榄球',
    },
    {
      id: 16,
      key: 'barbarians',
      name: 'Barbarians',
      event_name: '野蛮人 Barbarians',
    },
    {
      id: 17,
      key: 'anglo-welsh-cup',
      name: 'Anglo Welsh Cup',
      event_name: '盎格鲁威尔士杯',
    },
    {
      id: 18,
      key: 'mitre-10-cup',
      name: 'Mitre 10 Cup',
      event_name: '新西兰 Mitre 10 Cup',
      wiki: true,
    },
    {
      id: 19,
      key: 'national-rugby-championship',
      name: 'National Rugby Championship',
      event_name: '澳大利亚国家橄榄球冠军赛 NRC',
      wiki: true,
    },
    {
      id: 20,
      key: 'major-league-rugby',
      name: 'Major League Rugby',
      event_name: '美国职业橄榄球大联盟 MLR',
      wiki: true,
    },
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
  }.freeze

  class << self
    def event_id(event_key)
      EVENT_NAME_ID_MAP[event_key.to_sym]
    end

    def event(event_id)
      EVENT_LIST[event_id]
    end

    def key(event_id)
      EVENT_LIST[event_id][:key]
    end

    def page_key(event_id)
      event_key = Events::key(event_id)
      event_key.split('-').join('_')
    end

    def name(event_id)
      EVENT_LIST[event_id][:name]
    end

    def event_name(event_id)
      EVENT_LIST[event_id][:event_name]
    end

    def wiki?(event_id)
      return false unless EVENT_LIST[event_id].key?(:wiki)
      EVENT_LIST[event_id][:wiki]
    end

    def events_for_options
      event_list = []
      EVENT_LIST.each do |event|
        event_list << [event[:name], event[:id]]
      end

      event_list
    end
  end
end
