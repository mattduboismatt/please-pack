import React from 'react'
import { Link } from 'react-router'

export default class PoolRow extends React.Component {
  render() {
    let { pool, admin } = this.props
    let poolPath = `/pools/${pool.model_id}`

    if (admin) {
      var scorePoolLink = <Link to={poolPath + '/score'}>Score</Link>
    }

    return (
      <div className='pool'>
        <Link to={poolPath}>{pool.title}</Link>
        {scorePoolLink}
      </div>
    )
  }
}
