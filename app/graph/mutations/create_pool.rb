module Mutations
  CreatePool = GraphQL::Relay::Mutation.define do
    name "CreatePool"

    input_field :pool_title, !types.String

    return_field :pool, Queries::PoolType

    resolve ->(inputs, _context) do
      pool = Pool.create!(title: inputs[:pool_title])
      { pool: pool }
    end
  end
end
