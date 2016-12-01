import React from 'react'

import PoolRow from 'pages/pool_row'

export default class PoolsList extends React.Component {
  render() {
    let { pools, admin } = this.props

    return (
      <div className='pools-list'>
        {pools.map(pool => <PoolRow key={pool.id} pool={pool} admin={admin} />)}
      </div>
    )
  }
}
