import React from 'react'
import Relay from 'react-relay'

class ContestantRow extends React.Component {
  render() {
    let { contestant } = this.props

    return(
      <div className='contestant'>
        <span className='first-name'>{contestant.first_name}</span>
        <span>{contestant.last_name}</span>
        <span>{contestant.residence}</span>
        <span>{contestant.description}</span>
        <span className='points'>{contestant.points}</span>
      </div>
    )
  }
}

export default Relay.createContainer(ContestantRow, {
  fragments: {
    contestant: () => Relay.QL`
      fragment on Contestant {
        first_name
        last_name
        residence
        description
        points
      }
    `
  }
})

