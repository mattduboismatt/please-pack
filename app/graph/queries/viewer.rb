module Queries
  Viewer = GraphQL::ObjectType.define do
    name "Viewer"
    description "A container for top level parts of the graph"
    interfaces [NodeIdentification.interface]
    global_id_field :id

    field :pool do
      type !PoolType
      argument :model_id, !types.ID, "The ID of the Pool"
      resolve ->(_object, args, _context) { Pool.find(args["model_id"]) }
    end

    connection :pools, PoolType.connection_type do
      description "All pools in order of id"

      resolve ->(_object, _args, _context) { Pool.all }
    end
  end
end
