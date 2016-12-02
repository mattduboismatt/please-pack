GraphqlSchema = GraphQL::Schema.define do
  query Queries::RootType
  mutation Mutations::RootType
end

GraphqlSchema.rescue_from(ActiveRecord::RecordInvalid) do |error|
  error.record.errors.full_messages.to_sentence
end
