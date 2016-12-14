import Relay, { Mutation } from 'react-relay'

export default class SavePicks extends Mutation {
  getMutation() {
    return Relay.QL`mutation { save_picks }`
  }

  getVariables() {
    return {
      entry_id: this.props.entry.model_id,
      contestant_ids: this.props.contestant_ids
    }
  }

  getFatQuery() {
    return Relay.QL`
      fragment on SavePicksPayload {
        entry {
          picks
          points
        }
      }
    `
  }

  getConfigs() {
    return [{
      type: 'FIELDS_CHANGE',
      fieldIDs: {
        entry: this.props.entry.id
      }
    }]
  }

  static fragments = {
    entry: () => Relay.QL`
      fragment on Entry {
        id
        model_id
      }
    `
  }
}
