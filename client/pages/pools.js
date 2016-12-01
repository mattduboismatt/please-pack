import React from 'react'
import Relay from 'react-relay'
import { Link } from 'react-router'

class Pool extends React.Component {
  render() {
    const { pool } = this.props
    const poolPath = `/pools/${pool.model_id}`

    return (
      <div className='pool'>
        <Link to={poolPath}>{pool.title}</Link>
      </div>
    )
  }
}

class Pools extends React.Component {
  render() {
    let { pools } = this.props.lists

    return (
      <div>
        <h2>Pools!</h2>
        <div className='pools-list'>
          {pools.map(pool => <Pool key={pool.id} pool={pool}/>)}
        </div>
      </div>
    )
  }
}

export default Relay.createContainer(Pools, {
  fragments: {
    lists: () => Relay.QL`
      fragment on Lists {
        pools {
          id
          model_id
          title
        }
      }
    `
  }
})
