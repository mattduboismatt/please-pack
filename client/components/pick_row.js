import React from 'react'
import Relay from 'react-relay'

class PickRow extends React.Component {
  render() {
    let { pick } = this.props

    let scores = _.groupBy(pick.contestant.scores.map(score => score.mechanism))
    scores.advancement = scores.advancement || []
    scores.quickfire = scores.quickfire || []
    scores.weekly_winner = scores.weekly_winner || []

    return (
      <div className='pick'>
        <div className='first-name'>{pick.contestant.first_name}</div>
        <div className='breakdown'>
          <span>Advanced {scores.advancement.length} weeks +</span>
          <span>{scores.quickfire.length} QFs +</span>
          <span>{scores.weekly_winner.length} WWs</span>
        </div>
        <div className='points'>{pick.contestant.points}</div>
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
          scores {
            mechanism
          }
        }
      }
    `
  }
})
