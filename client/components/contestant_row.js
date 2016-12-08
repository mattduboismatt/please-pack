import React from 'react'
import Relay from 'react-relay'

class ContestantRow extends React.Component {
  render() {
    let { contestant } = this.props

    return(
      <div className='contestant'>
        <span>{contestant.first_name}</span>
        <span>{contestant.last_name}</span>
        <span>{contestant.residence}</span>
        <span>{contestant.description}</span>
        <span>0</span>
      </div>
    )
  }
}

export default Relay.createContainer(ContestantRow, {
  fragments: {
    contestant: () => Relay.QL`
      fragment on ContestantType {
        first_name
        last_name
        residence
        description
      }
    `
  }
})

