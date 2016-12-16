import React from 'react'
import Relay from 'react-relay'
import { Link } from 'react-router'

import PickRow from 'components/pick_row'
import DeleteEntryMutation from 'mutations/delete_entry'

class EntryRow extends React.Component {
  state = { showPicks: false }

  displayPicks = () => {
    let { picks } = this.props.entry

    if (this.state.showPicks) {
      if (picks.length > 0) {
        return picks.map(pick => <PickRow key={pick.id} pick={pick} />)
      } else {
        return <div className='pick'>No picks at this time</div>
      }
    }
  }

  handleDisplayPicksChange = (e) => {
    if (!e.target.hasAttribute('href')) {
      this.setState({ showPicks: !this.state.showPicks })
    }
  }

  handleRemoveEntry = () => {
    let mutation = new DeleteEntryMutation({
      entry: this.props.entry,
      pool: this.props.entry.pool
    })

    Relay.Store.commitUpdate(mutation)
  }

  render() {
    let { entry, admin } = this.props

    if (admin) {
      let entryPicksPath = `/entries/${entry.model_id}/picks`
      var makePicksLink = <Link to={entryPicksPath} className='admin-link'>Make Picks</Link>
      var removeEntryLink = <a href='javascript:;' className='admin-link remove' onClick={this.handleRemoveEntry}>Remove</a>
    }

    return(
      <div className='entry' onClick={this.handleDisplayPicksChange}>
        <span className='name'>{entry.name}</span>
        <span className='points'>{entry.points}</span>
        {makePicksLink}
        {removeEntryLink}
        {this.displayPicks()}
      </div>
    )
  }
}

export default Relay.createContainer(EntryRow, {
  fragments: {
    entry: () => Relay.QL`
      fragment on Entry {
        model_id
        name
        points
        picks {
          id
          ${PickRow.getFragment('pick')}
        }
        ${DeleteEntryMutation.getFragment('entry')}
      }
    `
  }
})
