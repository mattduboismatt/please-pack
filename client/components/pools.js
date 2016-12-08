import React from 'react'
import Relay from 'react-relay'

import PoolsList from 'components/pools_list'

class Pools extends React.Component {
  render() {
    let { pools } = this.props.viewer

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
    viewer: () => Relay.QL`
      fragment on Viewer {
        id
        pools(first: 100) {
          ${PoolsList.getFragment('pools')}
        }
      }
    `
  }
})
