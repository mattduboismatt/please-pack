module Queries
  Viewer = GraphQL::ObjectType.define do
    name "Viewer"
    description "A container for top level parts of the graph"
    interfaces [NodeIdentification.interface]
    global_id_field :id

    field :pool do
      type !PoolType
      argument :model_id, !types.ID, "The ID of the Pool"
      resolve ->(_object, args, _context) do
        Pool.includes(contestants: :scores, entries: { contestants: :scores }).find(args["model_id"])
      end
    end

    field :entry do
      type !EntryType
      argument :model_id, !types.ID, "The ID of the Entry"
      resolve ->(_object, args, _context) { ::Entry.find(args["model_id"]) }
    end

    connection :pools, PoolType.connection_type do
      description "All pools in order of id"

      resolve ->(_object, _args, _context) { ::Pool.all }
    end

    field :score_mechanisms do
      type !types[types.String]
      description "Options for the score mechanism"
      resolve ->(_object, _args, _context) { ::Score::MECHANISMS.all }
    end

    connection :scores, ScoreType.connection_type do
      description "All scores in order of id"

      resolve ->(_object, _args, _context) { ::Score.all }
    end
  end
end
