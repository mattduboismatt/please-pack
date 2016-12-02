module Queries
  RootType = GraphQL::ObjectType.define do
    name "RootType"
    description "The query root of this schema"

    field :node, field: NodeIdentification.field

    field :viewer do
      type Queries::Viewer
      resolve ->(_object, _args, _context) { ::Viewer }
    end
  end
end
