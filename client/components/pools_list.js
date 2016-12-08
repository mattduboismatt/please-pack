import React from 'react'
import Relay from 'react-relay'

import PoolRow from 'components/pool_row'

class PoolsList extends React.Component {
  render() {
    let { admin } = this.props
    let pools = this.props.pools.edges.map(pool => pool.node)

    return (
      <div className='pools-list'>
        {pools.map(pool => <PoolRow key={pool.id} pool={pool} admin={admin} />)}
      </div>
    )
  }
}

export default Relay.createContainer(PoolsList, {
  fragments: {
    pools: () => Relay.QL`
      fragment on PoolConnection {
        edges {
          node {
            id
            ${PoolRow.getFragment('pool')}
          }
        }
      }
    `
  }
})
