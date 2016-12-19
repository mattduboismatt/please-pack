import React from 'react'
import Relay from 'react-relay'
import classNames from 'classnames'

import DeleteContestantMutation from 'mutations/delete_contestant'

class ContestantRow extends React.Component {
  state = { showDetails: false }

  displayDetails = () => {
    let { contestant } = this.props

    if (this.state.showDetails) {
      return (
        <div className='details'>
          <p>{contestant.residence}</p>
          <p>{contestant.description}</p>
        </div>
      )
    }
  }

  handleDisplayDetailsChange = (e) => {
    if (!e.target.hasAttribute('href')) {
      this.setState({ showDetails: !this.state.showDetails })
    }
  }

  handleRemoveContestant = (e) => {
    e.preventDefault()

    let mutation = new DeleteContestantMutation({
      contestant: this.props.contestant,
      pool: this.props.contestant.pool
    })

    Relay.Store.commitUpdate(mutation)
  }

  render() {
    let { contestant, admin } = this.props

    let contestantClassNames = classNames('contestant', {
      'eliminated': contestant.eliminated
    })

    if (admin) {
      var removeContestantLink = <a href='#' className='admin-link remove' onClick={this.handleRemoveContestant}>Remove</a>
    }

    return(
      <div className={contestantClassNames} onClick={this.handleDisplayDetailsChange}>
        <span className='first-name'>{contestant.first_name}</span>
        <span className='points'>{contestant.points}</span>
        {removeContestantLink}
        {this.displayDetails()}
      </div>
    )
  }
}

export default Relay.createContainer(ContestantRow, {
  fragments: {
    contestant: () => Relay.QL`
      fragment on Contestant {
        first_name
        residence
        description
        points
        eliminated
        ${DeleteContestantMutation.getFragment('contestant')}
      }
    `
  }
})
