import Relay, { Mutation } from 'react-relay'

export default class CreateEliminationMutation extends Mutation {
  getMutation() {
    return Relay.QL`mutation { create_elimination }`
  }

  getVariables() {
    return {
      points: this.props.points,
      pool_id: this.props.pool.model_id,
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
