import React from 'react'
import Relay from 'react-relay'
import { Link } from 'react-router'

class PoolRow extends React.Component {
  render() {
    let { pool, admin } = this.props
    let poolPath = `/pools/${pool.model_id}`

    if (admin) {
      var setupPoolLink = <Link to={poolPath + '/setup'} className='admin-link'>Setup</Link>
      var scorePoolLink = <Link to={poolPath + '/score'} className='admin-link'>Score</Link>
    }

    return (
      <div className='pool'>
        <Link to={poolPath} className='pool-link'>{pool.title}</Link>
        <div className='admin-links'>
          {setupPoolLink}
          {scorePoolLink}
        </div>
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
