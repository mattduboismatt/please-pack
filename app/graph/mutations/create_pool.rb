module Mutations
  CreatePool = GraphQL::Relay::Mutation.define do
    name "CreatePool"

    input_field :pool_title, !types.String

    return_field :pool_edge, Queries::PoolType.edge_type
    return_field :viewer, Queries::Viewer

    resolve ->(inputs, _context) do
      connection = GraphQL::Relay::RelationConnection.new(Pool.all, {})
      pool = Pool.create!(title: inputs[:pool_title])

      {
        pool_edge: GraphQL::Relay::Edge.new(pool, connection),
        viewer: Viewer
      }
    end
  end
end
