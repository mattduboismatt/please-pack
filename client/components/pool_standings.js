import React from 'react'
import Relay from 'react-relay'

import EntriesList from 'components/entries_list'
import ContestantsList from 'components/contestants_list'

class PoolStandings extends React.Component {
  render() {
    let { pool } = this.props.viewer

    return (
      <div className='standings'>
        <h5>Standings</h5>
        <EntriesList entries={pool.entries} />
        <ContestantsList contestants={pool.contestants} />
      </div>
    )
  }
}

export default Relay.createContainer(PoolStandings, {
  initialVariables: {
    model_id: null
  },

  fragments: {
    viewer: () => Relay.QL`
      fragment on Viewer {
        pool(model_id: $model_id) {
          model_id
          entries(first: 100) {
            ${EntriesList.getFragment('entries')}
          }
          contestants(first: 100) {
            ${ContestantsList.getFragment('contestants')}
          }
        }
      }
    `
  }
})
