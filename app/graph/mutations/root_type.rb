module Mutations
  RootType = GraphQL::ObjectType.define do
    name "RootMutation"
    description "The mutation root of this schema"

    field :create_pool, field: CreatePool.field
    field :create_contestant, field: CreateContestant.field
    field :create_entry, field: CreateEntry.field
    field :save_picks, field: SavePicks.field
    field :create_score, field: CreateScore.field
    field :delete_entry, field: DeleteEntry.field
    field :delete_contestant, field: DeleteContestant.field
    field :delete_pool, field: DeletePool.field
    field :create_elimination, field: CreateElimination.field
  end
end
