module Mutations
  DeletePool = GraphQL::Relay::Mutation.define do
    name "DeletePool"

    input_field :pool_id, !types.ID

    return_field :pool_id, !types.ID
    return_field :viewer, !Queries::Viewer

    resolve ->(inputs, _context) do
      pool = Queries::NodeIdentification.object_from_id(inputs[:pool_id], {})
      pool.destroy!

      {
        pool_id: inputs[:pool_id],
        viewer: ::Viewer
      }
    end
  end
end
