import React from 'react'
import Relay from 'react-relay'

import PoolsList from 'components/pools_list'

class Admin extends React.Component {
  render() {
    let { pools } = this.props.lists

    return (
      <div>
        <h2>Super Secret Admin Panel</h2>
        <PoolsList pools={pools} admin={true}/>
      </div>
    )
  }
}

export default Relay.createContainer(Admin, {
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
