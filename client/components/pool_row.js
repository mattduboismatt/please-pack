import React from 'react'
import Relay from 'react-relay'
import { Link } from 'react-router'

class PoolRow extends React.Component {
  render() {
    let { pool, admin } = this.props
    let poolPath = `/pools/${pool.model_id}`

    if (admin) {
      var setupPoolLink = <Link to={poolPath + '/setup'}>Setup</Link>
      var scorePoolLink = <Link to={poolPath + '/score'}>Score</Link>
    }

    return (
      <div className='pool'>
        <Link to={poolPath}>{pool.title}</Link>
        {setupPoolLink}
        {scorePoolLink}
      </div>
    )
  }
}

export default Relay.createContainer(PoolRow, {
  fragments: {
    pool: () => Relay.QL`
      fragment on Pool {
        model_id
        title
      }
    `
  }
})
