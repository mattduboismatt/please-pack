import React from 'react'
import Relay from 'react-relay'
import { Link } from 'react-router'

import PickRow from 'components/pick_row'

class EntryRow extends React.Component {
  state = { showPicks: false }

  displayPicks = () => {
    let { picks } = this.props.entry

    if (this.state.showPicks) {
      return picks.map(pick => <PickRow key={pick.id} pick={pick} />)
    }
  }

  handleDisplayPicksChange = () => {
    this.setState({ showPicks: !this.state.showPicks })
  }

  displayPicksText = () => {
    return this.state.showPicks ? "Hide" : "Show"
  }

  render() {
    let { entry, admin } = this.props

    if (admin) {
      let entryPicksPath = `/entries/${entry.model_id}/picks`
      var makePicksLink = <Link to={entryPicksPath} className='make-picks'>Make Picks</Link>
    }

    return(
      <div className='entry'>
        <span className='name'>{entry.name}</span>
        <span className='points'>{entry.points}</span>
        {makePicksLink}
        <a href='javascript:;' className='display-picks' onClick={this.handleDisplayPicksChange}>{this.displayPicksText()}</a>
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
