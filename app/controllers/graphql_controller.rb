class GraphqlController < ApplicationController
  # Ignore CSRF, rely on some auth token
  protect_from_forgery except: [:create]

  def create
    query_string = params[:query]
    query_variables = params[:variables] || {}
    query = GraphQL::Query.new(GraphqlSchema, query_string, variables: query_variables)
    render json: query.result
  end
end
