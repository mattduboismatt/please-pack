module Queries
  NodeIdentification = GraphQL::Relay::GlobalNodeIdentification.define do
    # Given a UUID & the query context,
    # return the corresponding application object
    object_from_id ->(id, _config) do
      type_name, id = NodeIdentification.from_global_id(id)
      return Viewer if id == Viewer.id
      type_name.constantize.find(id)
    end

    # Given an application object,
    # return a GraphQL ObjectType to expose that object
    type_from_object ->(object) do
      GraphqlSchema.types[object.class.name]
    end
  end
end

GraphqlSchema.node_identification = Queries::NodeIdentification
