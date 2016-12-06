import React from 'react'
import Relay from 'react-relay'

class PoolStandings extends React.Component {
  render() {
    let { pool } = this.props.viewer

    return (
      <div className='standings'>Standings</div>
    )
  }
}

export default Relay.createContainer(PoolStandings, {
  initialVariables: {
    model_id: null
  },

  fragments: {
    viewer: () => Relay.QL`
      fragment on Viewer {
        pool(model_id: $model_id) {
          id
          model_id
        }
      }
    `
  }
})
