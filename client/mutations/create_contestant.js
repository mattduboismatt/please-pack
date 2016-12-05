import Relay, { Mutation } from 'react-relay'

export default class CreateContestantMutation extends Mutation {
  getMutation() {
    return Relay.QL`mutation { create_contestant }`
  }

  getVariables() {
    return {
      pool_id: this.props.pool_id,
      first_name: this.props.first_name,
      last_name: this.props.last_name,
      residence: this.props.residence,
      description: this.props.description
    }
  }

  getFatQuery() {
    return Relay.QL`
      fragment on CreateContestantPayload {
        contestant_edge
        pool
      }
    `
  }

  getConfigs() {
    return [{
      type: 'RANGE_ADD',
      parentName: 'pool',
      parentID: this.props.pool_id,
      connectionName: 'contestants',
      edgeName: 'contestant_edge',
      rangeBehaviors: {
        '': 'append'
      }
    }]
  }
}
