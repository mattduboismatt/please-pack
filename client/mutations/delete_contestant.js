import Relay, { Mutation } from 'react-relay'

export default class DeleteContestantMutation extends Mutation {
  getMutation() {
    return Relay.QL`mutation { delete_contestant }`
  }

  getVariables() {
    return {
      contestant_id: this.props.contestant.id
    }
  }

  getFatQuery() {
    return Relay.QL`
      fragment on DeleteContestantPayload {
        contestant_id
        pool
      }
    `
  }

  getConfigs() {
    return [{
      type: 'NODE_DELETE',
      parentName: 'pool',
      parentID: this.props.contestant.pool.id,
      connectionName: 'contestants',
      deletedIDFieldName: 'contestant_id'
    }]
  }

  static fragments = {
    contestant: () => Relay.QL`
      fragment on Contestant {
        id
        pool {
          id
        }
      }
    `
  }
}
