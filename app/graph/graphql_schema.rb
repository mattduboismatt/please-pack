GraphqlSchema = GraphQL::Schema.define do
  query Queries::RootType
  mutation Mutations::RootType
end
