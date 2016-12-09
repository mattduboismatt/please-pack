module Queries
  EntryType = GraphQL::ObjectType.define do
    name "Entry"
    description "An entry in a pool"
    interfaces [NodeIdentification.interface]
    global_id_field :id

    field :model_id, !types.Int, property: :id
    field :name, !types.String
    field :points, !types.Int
    field :pool, !PoolType
    field :picks do
      type !types[PickType]
      resolve ->(object, _args, _context) { object.picks.sort_by { |pick| pick.contestant.points }.reverse }
    end
  end
end
