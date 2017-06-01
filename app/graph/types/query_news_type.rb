module Types
  QueryNewsType = GraphQL::ObjectType.define do
    name "Query News"
    description "Query News Item"

    field :news do
      type Types::NewsType
      argument :id, !types.ID
      description "Find a news by ID"

      resolve ->(obj, args, ctx) do
        News.find(args["id"])
      end
    end

    field :list do
      type Types::NewsType.to_list_type
      description "Find list by conditions"

      argument :channel, types.Int, default_value: 0
      argument :event, types.Int, default_value: 0
      argument :page, types.Int, default_value: 1
      argument :size, types.Int, default_value: 10

      resolve ->(obj, args, ctx) do
        News.where(channel: args["channel"], event: args["event"])
      end
    end
  end
end
