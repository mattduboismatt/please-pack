import React from 'react'
import { Link } from 'react-router'

export default class PoolRow extends React.Component {
  scorePoolLink = () => {
    let { admin, pool } = this.props

    if (admin) {
      let scorePoolPath = `/pools/${pool.model_id}/score`
      return <Link to={scorePoolPath}>Score</Link>
    }
  }

  render() {
    let { pool } = this.props
    let poolPath = `/pools/${pool.model_id}`

    return (
      <div className='pool'>
        <Link to={poolPath}>{pool.title}</Link>
        {this.scorePoolLink()}
      </div>
    )
  }
}
