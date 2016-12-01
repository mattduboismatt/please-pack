import React from 'react'
import Relay from 'react-relay'

import PoolsList from 'components/pools_list'

class Pools extends React.Component {
  render() {
    let { pools } = this.props.lists

    return (
      <div>
        <h2>Pools!</h2>
        <PoolsList pools={pools} />
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
