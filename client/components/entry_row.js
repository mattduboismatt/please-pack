import React from 'react'
import Relay from 'react-relay'
import { Link } from 'react-router'

import PickRow from 'components/pick_row'

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

  render() {
    let { entry, admin } = this.props

    if (admin) {
      let entryPicksPath = `/entries/${entry.model_id}/picks`
      var makePicksLink = <Link to={entryPicksPath} className='make-picks admin-link'>Make Picks</Link>
    }

    return(
      <div className='entry' onClick={this.handleDisplayPicksChange}>
        <span className='name'>{entry.name}</span>
        <span className='points'>{entry.points}</span>
        {makePicksLink}
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
      }
    `
  }
})
