module Queries
  PoolType = GraphQL::ObjectType.define do
    name "Pool"
    description "A tournament pool"
    interfaces [NodeIdentification.interface]
    global_id_field :id

    field :model_id, !types.Int, property: :id
    field :title, !types.String

    connection :contestants do
      type !ContestantType.connection_type
      description "Contestants for the pool"
      resolve ->(object, _args, _context) { object.contestants.sort_by(&:points).reverse }
    end

    connection :entries do
      type !EntryType.connection_type
      description "Entries for the pool"
      resolve ->(object, _args, _context) { object.entries.sort_by(&:points).reverse }
    end
  end
end
