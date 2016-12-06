import React from 'react'
import { Link } from 'react-router'

export default class EntryRow extends React.Component {
  render() {
    let { entry } = this.props

    let entrySelectionsLink = `/entries/${entry.model_id}/selections`

    return(
      <div className='entry'>
        <span>{entry.name}</span>
        <span>{entry.points}</span>
        <Link to={entrySelectionsLink} className='make-selections'>Make Selections</Link>
      </div>
    )
  }
}
