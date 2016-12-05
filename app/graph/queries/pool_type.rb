module Queries
  PoolType = GraphQL::ObjectType.define do
    name "Pool"
    description "A tournament pool"
    interfaces [NodeIdentification.interface]
    global_id_field :id

    field :model_id, !types.Int, property: :id
    field :title, !types.String

    connection :contestants, ContestantType.connection_type do
      description "Contestants for the pool"

      resolve ->(pool, _args, _context) { pool.contestants }
    end
  end
end
