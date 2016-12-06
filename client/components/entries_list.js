import React from 'react'
import { Link } from 'react-router'

class EntryRow extends React.Component {
  render() {
    let { entry } = this.props

    let entryPicksLink = `/entries/${entry.model_id}/picks`

    return(
      <div className='entry'>
        <span>{entry.name}</span>
        <span>{entry.points}</span>
        <Link to={entryPicksLink} className='make-picks'>Make Picks</Link>
      </div>
    )
  }
}

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
