module Queries
  EntryType = GraphQL::ObjectType.define do
    name "EntryType"
    description "An entry in a pool"
    interfaces [NodeIdentification.interface]
    global_id_field :id

    field :model_id, !types.Int, property: :id
    field :name, !types.String
    field :points, !types.Int
    field :pool, PoolType
  end
end
