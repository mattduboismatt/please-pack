module Queries
  ListsType = GraphQL::ObjectType.define do
    name "Lists"
    description "Top level lists"

    field :pools, !types[PoolType] do
      description "All pools available"
      resolve ->(_object, _args, _context) { Pool.all }
    end
  end
end
