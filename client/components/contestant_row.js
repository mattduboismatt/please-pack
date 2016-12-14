import React from 'react'
import Relay from 'react-relay'

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

  handleDisplayDetailsChange = () => {
    this.setState({ showDetails: !this.state.showDetails })
  }

  render() {
    let { contestant } = this.props

    return(
      <div className='contestant' onClick={this.handleDisplayDetailsChange}>
        <span className='first-name'>{contestant.first_name}</span>
        <span className='points'>{contestant.points}</span>
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
      }
    `
  }
})

