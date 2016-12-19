module Mutations
  CreateElimination = GraphQL::Relay::Mutation.define do
    name "CreateElimination"

    input_field :points, !types.String
    input_field :contestant_ids, !types[types.ID]
    input_field :pool_id, !types.ID

    return_field :score_edge, Queries::ScoreType.edge_type
    return_field :viewer, Queries::Viewer

    resolve ->(inputs, _context) do
      contestants_to_eliminate = ::Contestant.where(id: inputs[:contestant_ids])
      raise GraphQL::ExecutionError, "Contestants must not be empty" if contestants_to_eliminate.empty?
      raise GraphQL::ExecutionError, "Contestant has already been eliminated" if contestants_to_eliminate.any?(&:eliminated?)

      contestants_to_eliminate.update_all(eliminated: true)

      remaining_contestants = ::Pool.find(inputs[:pool_id]).contestants.active
      score = ::Score.new(points: inputs[:points], mechanism: ::Score::MECHANISMS::ADVANCEMENT)
      score.contestants << remaining_contestants
      score.save!
      connection = GraphQL::Relay::RelationConnection.new(Score.all, {})

      {
        score_edge: GraphQL::Relay::Edge.new(score, connection),
        viewer: ::Viewer
      }
    end
  end
end
