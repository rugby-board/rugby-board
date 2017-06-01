module Types
  NewsType = GraphQL::ObjectType.define do
    name "News"
    description "A rugby board news"

    field :id, !types.ID
    field :title, !types.String
    field :channel, ChannelEnum
    field :event, EventEnum
    field :content, !types.String
    field :markdown_content, !types.String
    field :tag, !types.String
    field :created_at, !types.Int
    field :updated_at, !types.Int
  end
end
