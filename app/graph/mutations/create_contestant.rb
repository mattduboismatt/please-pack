module Mutations
  CreateContestant = GraphQL::Relay::Mutation.define do
    name "CreateContestant"

    input_field :pool_id, !types.ID
    input_field :first_name, !types.String
    input_field :last_name, types.String
    input_field :residence, types.String
    input_field :description, types.String

    return_field :contestant_edge, Queries::ContestantType.edge_type
    return_field :pool, Queries::PoolType

    resolve ->(inputs, _context) do
      pool = Queries::NodeIdentification.object_from_id(inputs[:pool_id], {})
      contestant = pool.contestants.create!(
        first_name: inputs[:first_name],
        last_name: inputs[:last_name],
        residence: inputs[:residence],
        description: inputs[:description]
      )

      connection = GraphQL::Relay::RelationConnection.new(pool.contestants, {})

      {
        contestant_edge: GraphQL::Relay::Edge.new(contestant, connection),
        pool: pool
      }
    end
  end
end
