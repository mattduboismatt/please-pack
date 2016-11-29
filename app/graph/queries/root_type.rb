module Queries
  RootType = GraphQL::ObjectType.define do
    name "RootType"
    description "The query root of this schema"

    field :node, field: NodeIdentification.field

    field :lists do
      type !ListsType
      resolve ->(_object, _args, _context) { {} }
    end

    field :pool do
      type !PoolType
      argument :model_id, !types.ID, "The ID of the Pool"
      resolve ->(_object, args, _context) { Pool.find(args["model_id"]) }
    end
  end
end
