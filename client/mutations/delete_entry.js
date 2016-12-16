import Relay, { Mutation } from 'react-relay'

export default class DeleteEntryMutation extends Mutation {
  getMutation() {
    return Relay.QL`mutation { delete_entry }`
  }

  getVariables() {
    return {
      entry_id: this.props.entry.id
    }
  }

  getFatQuery() {
    return Relay.QL`
      fragment on DeleteEntryPayload {
        entry_id
        pool
      }
    `
  }

  getConfigs() {
    return [{
      type: 'NODE_DELETE',
      parentName: 'pool',
      parentID: this.props.entry.pool.id,
      connectionName: 'entries',
      deletedIDFieldName: 'entry_id'
    }]
  }

  static fragments = {
    entry: () => Relay.QL`
      fragment on Entry {
        id
        pool {
          id
        }
      }
    `
  }
}
