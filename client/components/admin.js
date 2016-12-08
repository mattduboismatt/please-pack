import React from 'react'
import Relay from 'react-relay'

import PoolsList from 'components/pools_list'
import CreatePoolForm from 'components/create_pool_form'

class Admin extends React.Component {
  render() {
    let { viewer } = this.props
    let { pools } = this.props.viewer

    return (
      <div>
        <h2>Super Secret Admin Panel</h2>
        <PoolsList pools={pools} admin={true}/>
        <CreatePoolForm viewer={viewer}/>
      </div>
    )
  }
}

export default Relay.createContainer(Admin, {
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
