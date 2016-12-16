module Mutations
  DeleteContestant = GraphQL::Relay::Mutation.define do
    name "DeleteContestant"

    input_field :contestant_id, !types.ID

    return_field :contestant_id, !types.ID
    return_field :pool, !Queries::PoolType

    resolve ->(inputs, _context) do
      contestant = Queries::NodeIdentification.object_from_id(inputs[:contestant_id], {})
      pool = contestant.pool
      contestant.destroy!

      {
        contestant_id: inputs[:contestant_id],
        pool: pool
      }
    end
  end
end
