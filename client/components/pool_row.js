import React from 'react'
import Relay from 'react-relay'
import { Link } from 'react-router'

import DeletePoolMutation from 'mutations/delete_pool'

class PoolRow extends React.Component {
  handleRemovePool = (e) => {
    let mutation = new DeletePoolMutation({
      pool: this.props.pool,
      viewer: this.props.viewer
    })

    Relay.Store.commitUpdate(mutation)
  }

  render() {
    let { pool, admin } = this.props
    let poolPath = `/pools/${pool.model_id}`

    if (admin) {
      var setupPoolLink = <Link to={poolPath + '/setup'} className='admin-link'>Setup</Link>
      var scorePoolLink = <Link to={poolPath + '/score'} className='admin-link'>Score</Link>
      var removePoolLink = <a href='#' className='admin-link remove' onClick={this.handleRemovePool}>Remove</a>
    }

    return (
      <div className='pool'>
        <Link to={poolPath} className='pool-link'>{pool.title}</Link>
        <div className='admin-links'>
          {setupPoolLink}
          {scorePoolLink}
          {removePoolLink}
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
        ${DeletePoolMutation.getFragment('pool')}
      }
    `
  }
})
