import React from 'react'
import Relay from 'react-relay'

import ContestantsList from 'components/contestants_list'
import CreateContestantForm from 'components/create_contestant_form'
import EntriesList from 'components/entries_list'
import CreateEntryForm from 'components/create_entry_form'

class PoolScoring extends React.Component {
  render() {
    let { pool } = this.props.viewer
    let contestants = pool.contestants.edges.map(contestant => contestant.node)
    let entries = pool.entries.edges.map(entry => entry.node)

    return (
      <div className='pool'>
        <h2>{pool.title}</h2>
        <div className='scoring'>
          <p>Scoring</p>
          <div className='contestants'>
            <ContestantsList contestants={contestants} />
            <CreateContestantForm pool={pool} />
          </div>
          <div className='entries'>
            <EntriesList entries={entries} />
            <CreateEntryForm pool={pool} />
          </div>
        </div>
      </div>
    )
  }
}

export default Relay.createContainer(PoolScoring, {
  initialVariables: {
    model_id: null
  },

  fragments: {
    viewer: () => Relay.QL`
      fragment on Viewer {
        pool(model_id: $model_id) {
          id
          model_id
          title
          contestants(first: 100) {
            edges {
              node {
                id
                model_id
                first_name
                last_name
                residence
                description
              }
            }
          }
          entries(first: 100) {
            edges {
              node {
                id
                model_id
                name
                points
              }
            }
          }
        }
      }
    `
  }
})
