GraphqlSchema = GraphQL::Schema.define do
  query Queries::RootType
end
