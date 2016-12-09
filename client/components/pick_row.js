import React from 'react'
import Relay from 'react-relay'

class PickRow extends React.Component {
  render() {
    let { pick } = this.props

    return (
      <div className='pick'>
        <span className='first-name'>{pick.contestant.first_name}</span>
        <span className='points'>{pick.contestant.points}</span>
      </div>
    )
  }
}

export default Relay.createContainer(PickRow, {
  fragments: {
    pick: () => Relay.QL`
      fragment on Pick {
        contestant {
          first_name
          points
        }
      }
    `
  }
})
