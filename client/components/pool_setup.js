import React from 'react'
import Relay from 'react-relay'

import ContestantsList from 'components/contestants_list'
import CreateContestantForm from 'components/create_contestant_form'
import EntriesList from 'components/entries_list'
import CreateEntryForm from 'components/create_entry_form'
import PoolAdminLinks from 'components/pool_admin_links'

class PoolSetup extends React.Component {
  render() {
    let { pool } = this.props.viewer

    return (
      <div className='setup'>
        <PoolAdminLinks pool={pool} />
        <div className='contestants'>
          <ContestantsList contestants={pool.contestants} admin={true} />
          <CreateContestantForm pool={pool} />
        </div>
        <div className='entries'>
          <EntriesList entries={pool.entries} admin={true} />
          <CreateEntryForm pool={pool} />
        </div>
      </div>
    )
  }
}

export default Relay.createContainer(PoolSetup, {
  initialVariables: {
    model_id: null
  },

  fragments: {
    viewer: () => Relay.QL`
      fragment on Viewer {
        pool(model_id: $model_id) {
          entries(first: 100) {
            ${EntriesList.getFragment('entries')}
          }
          contestants(first: 100) {
            ${ContestantsList.getFragment('contestants')}
          }
          ${CreateEntryForm.getFragment('pool')}
          ${CreateContestantForm.getFragment('pool')}
          ${PoolAdminLinks.getFragment('pool')}
        }
      }
    `
  }
})
