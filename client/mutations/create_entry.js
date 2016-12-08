import Relay, { Mutation } from 'react-relay'

export default class CreateEntryMutation extends Mutation {
  getMutation() {
    return Relay.QL`mutation { create_entry }`
  }

  getVariables() {
    return {
      pool_id: this.props.pool_id,
      name: this.props.name
    }
  }

  getFatQuery() {
    return Relay.QL`
      fragment on CreateEntryPayload {
        entry_edge
        pool
      }
    `
  }

  getConfigs() {
    return [{
      type: 'RANGE_ADD',
      parentName: 'pool',
      parentID: this.props.pool_id,
      connectionName: 'entries',
      edgeName: 'entry_edge',
      rangeBehaviors: {
        '': 'append'
      }
    }]
  }
}
