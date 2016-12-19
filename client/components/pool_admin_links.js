import React from 'react'
import Relay from 'react-relay'
import { Link } from 'react-router'

class PoolAdminLinks extends React.Component {
  render() {
    let poolPath = `/pools/${this.props.pool.model_id}`

    return (
      <div className='pool-admin-links'>
        <Link to={poolPath}>Standings</Link>
        <Link to={poolPath + '/setup'}>Setup</Link>
        <Link to={poolPath + '/score'}>Score</Link>
      </div>
    )
  }
}

export default Relay.createContainer(PoolAdminLinks, {
  fragments: {
    pool: () => Relay.QL`
      fragment on Pool {
        model_id
      }
    `
  }
})
