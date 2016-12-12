module Queries
  ScoreType = GraphQL::ObjectType.define do
    name "Score"
    description "A score for a set of contestants"
    interfaces [NodeIdentification.interface]
    global_id_field :id
    field :model_id, !types.Int, property: :id
    field :points, !types.Int
    field :mechanism, !types.String
  end
end
