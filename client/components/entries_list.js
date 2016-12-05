import React from 'react'

import EntryRow from 'components/entry_row'

export default class EntriesList extends React.Component {
  render() {
    let { entries } = this.props

    return (
      <div className='entries-list'>
        <h3>Entries</h3>
        {entries.map(entry => <EntryRow key={entry.id} entry={entry} />)}
      </div>
    )
  }
}
