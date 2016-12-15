module Mutations
  DeleteEntry = GraphQL::Relay::Mutation.define do
    name "DeleteEntry"

    input_field :entry_id, !types.ID

    return_field :entry_id, !types.ID
    return_field :pool, !Queries::PoolType

    resolve ->(inputs, _context) do
      entry = Queries::NodeIdentification.object_from_id(inputs[:entry_id], {})
      pool = entry.pool
      entry.destroy!

      {
        entry_id: inputs[:entry_id],
        pool: pool
      }
    end
  end
end
