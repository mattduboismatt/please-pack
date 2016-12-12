import Relay, { Mutation } from 'react-relay'

export default class CreateScoreMutation extends Mutation {
  getMutation() {
    return Relay.QL`mutation { create_score }`
  }

  getVariables() {
    return {
      points: this.props.points,
      mechanism: this.props.mechanism,
      contestant_ids: this.props.contestant_ids
    }
  }

  getFatQuery() {
    return Relay.QL`
      fragment on CreateScorePayload {
        score_edge,
        viewer {
          id
          scores
        }
      }
    `
  }

  getConfigs() {
    return [{
      type: 'RANGE_ADD',
      parentName: 'viewer',
      parentID: this.props.viewer.id,
      connectionName: 'scores',
      edgeName: 'score_edge',
      rangeBehaviors: {
        '': 'append'
      }
    }]
  }
}
