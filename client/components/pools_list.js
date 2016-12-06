import React from 'react'
import { Link } from 'react-router'

class PoolRow extends React.Component {
  render() {
    let { pool, admin } = this.props
    let poolPath = `/pools/${pool.model_id}`

    if (admin) {
      var setupPoolLink = <Link to={poolPath + '/setup'}>Setup</Link>
    }

    return (
      <div className='pool'>
        <Link to={poolPath}>{pool.title}</Link>
        {setupPoolLink}
      </div>
    )
  }
}

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
