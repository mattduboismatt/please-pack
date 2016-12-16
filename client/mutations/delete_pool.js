import Relay, { Mutation } from 'react-relay'

export default class DeletePoolMutation extends Mutation {
  getMutation() {
    return Relay.QL`mutation { delete_pool }`
  }

  getVariables() {
    return {
      pool_id: this.props.pool.id
    }
  }

  getFatQuery() {
    return Relay.QL`
      fragment on DeletePoolPayload {
        pool_id
        viewer
      }
    `
  }

  getConfigs() {
    return [{
      type: 'NODE_DELETE',
      parentName: 'viewer',
      parentID: this.props.viewer.id,
      connectionName: 'pools',
      deletedIDFieldName: 'pool_id'
    }]
  }

  static fragments = {
    pool: () => Relay.QL`
      fragment on Pool {
        id
      }
    `
  }
}
