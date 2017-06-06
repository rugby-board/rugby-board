module Types
  ChannelEnum = GraphQL::EnumType.define do
    name "Channel"
    description "Channel of News"
    News::CHANNEL_LIST.each do |channel|
      value(channel[0], "Channel #{channel[0]}", value: channel[1])
    end
  end
end
