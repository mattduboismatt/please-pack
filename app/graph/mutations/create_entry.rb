module Mutations
  CreateEntry = GraphQL::Relay::Mutation.define do
    name "CreateEntry"

    input_field :pool_id, !types.ID
    input_field :name, !types.String

    return_field :entry_edge, Queries::EntryType.edge_type
    return_field :pool, Queries::PoolType

    resolve ->(inputs, _context) do
      pool = Queries::NodeIdentification.object_from_id(inputs[:pool_id], {})
      entry = pool.entries.create!(
        name: inputs[:name],
        points: 0
      )

      connection = GraphQL::Relay::RelationConnection.new(pool.entries, {})

      {
        entry_edge: GraphQL::Relay::Edge.new(entry, connection),
        pool: pool
      }
    end
  end
end
