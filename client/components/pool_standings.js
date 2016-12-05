import React from 'react'
import Relay from 'react-relay'

class PoolStandings extends React.Component {
  render() {
    const { pool } = this.props.viewer

    return (
      <div className='pool'>
        <h2>{pool.title}</h2>
        <div className='standings'>Standings</div>
      </div>
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
          title
        }
      }
    `
  }
})
