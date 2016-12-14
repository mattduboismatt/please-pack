module Mutations
  CreateScore = GraphQL::Relay::Mutation.define do
    name "CreateScore"

    input_field :mechanism, !types.String
    input_field :points, !types.String
    input_field :contestant_ids, !types[types.ID]

    return_field :score_edge, Queries::ScoreType.edge_type
    return_field :viewer, Queries::Viewer

    resolve ->(inputs, _context) do
      score = ::Score.new(points: inputs[:points], mechanism: inputs[:mechanism])
      score.contestants << ::Contestant.find(inputs[:contestant_ids])
      score.save!
      connection = GraphQL::Relay::RelationConnection.new(Score.all, {})

      {
        score_edge: GraphQL::Relay::Edge.new(score, connection),
        viewer: Viewer
      }
    end
  end
end
