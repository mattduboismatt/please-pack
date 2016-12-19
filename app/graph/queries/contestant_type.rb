module Queries
  ContestantType = GraphQL::ObjectType.define do
    name "Contestant"
    description "A contestant in a pool"
    interfaces [NodeIdentification.interface]
    global_id_field :id

    field :model_id, !types.Int, property: :id
    field :first_name, !types.String
    field :last_name, types.String
    field :residence, types.String
    field :description, types.String
    field :points, !types.Int
    field :eliminated, !types.Boolean
    field :pool, !PoolType
  end
end
