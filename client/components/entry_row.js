import React from 'react'
import Relay from 'react-relay'
import { Link } from 'react-router'

class EntryRow extends React.Component {
  render() {
    let { entry, admin } = this.props

    if (admin) {
      let entryPicksPath = `/entries/${entry.model_id}/picks`
      var makePicksLink = <Link to={entryPicksPath} className='make-picks'>Make Picks</Link>
    }

    return(
      <div className='entry'>
        <span>{entry.name}</span>
        <span>{entry.points}</span>
        {makePicksLink}
      </div>
    )
  }
}

export default Relay.createContainer(EntryRow, {
  fragments: {
    entry: () => Relay.QL`
      fragment on EntryType {
        model_id
        name
        points
      }
    `
  }
})
