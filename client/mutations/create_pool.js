import Relay, { Mutation } from 'react-relay'

export default class CreatePoolMutation extends Mutation {
  getMutation() {
    return Relay.QL`mutation { create_pool }`
  }

  getVariables() {
    return { pool_title: this.props.pool_title }
  }

  getFatQuery() {
    return Relay.QL`
      fragment on CreatePoolPayload {
        pool_edge,
        viewer {
          id
          pools
        }
      }
    `
  }

  getConfigs() {
    return [{
      type: 'RANGE_ADD',
      parentName: 'viewer',
      parentID: this.props.viewer.id,
      connectionName: 'pools',
      edgeName: 'pool_edge',
      rangeBehaviors: {
        '': 'append'
      }
    }]
  }
}
