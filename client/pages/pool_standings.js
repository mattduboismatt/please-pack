import React from 'react'
import Relay from 'react-relay'

class PoolStandings extends React.Component {
  render() {
    const { pool } = this.props

    return (
      <div>
        <h2>{pool.title}</h2>
        <div className='standings'>Standings</div>
      </div>
    )
  }
}

export default Relay.createContainer(PoolStandings, {
  fragments: {
    pool: () => Relay.QL`
      fragment on Pool {
        id
        model_id
        title
      }
    `
  }
})
