module Queries
  PickType = GraphQL::ObjectType.define do
    name "Pick"
    description "A join between entry and contestant"
    interfaces [NodeIdentification.interface]
    global_id_field :id

    field :model_id, !types.Int, property: :id
    field :contestant, !ContestantType
    field :entry, !EntryType
  end
end
