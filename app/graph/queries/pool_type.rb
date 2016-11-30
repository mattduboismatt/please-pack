module Queries
  PoolType = GraphQL::ObjectType.define do
    name "Pool"
    description "A tournament pool"
    interfaces [NodeIdentification.interface]
    global_id_field :id

    field :model_id, !types.Int, property: :id
    field :title, !types.String
  end
end