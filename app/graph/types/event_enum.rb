module Types
  EventEnum = GraphQL::EnumType.define do
    name "Event"
    description "Event of News"
    News::EVENT_LIST.each do |event|
      value(event[0], "Event #{event[0]}", value: event[1])
    end
  end
end
