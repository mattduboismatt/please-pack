import React from 'react'
import Relay from 'react-relay'

import EntryRow from 'components/entry_row'

class EntriesList extends React.Component {
  render() {
    let { admin } = this.props
    let entries = this.props.entries.edges.map(entry => entry.node)

    return (
      <div className='entries-list'>
        <h3>Entries</h3>
        {entries.map(entry => <EntryRow key={entry.id} entry={entry} admin={admin} />)}
      </div>
    )
  }
}

export default Relay.createContainer(EntriesList, {
  fragments: {
    entries: () => Relay.QL`
      fragment on EntryTypeConnection {
        edges {
          node {
            id
            ${EntryRow.getFragment('entry')}
          }
        }
      }
    `
  }
})
