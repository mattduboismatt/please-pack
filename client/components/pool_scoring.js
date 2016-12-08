import React from 'react'
import Relay from 'react-relay'

class PoolScoring extends React.Component {
  render() {
    let { pool } = this.props.viewer

    return (
      <div className='scoring'>
        <p>Scoring</p>
      </div>
    )
  }
}

export default Relay.createContainer(PoolScoring, {
  initialVariables: {
    model_id: null
  },

  fragments: {
    viewer: () => Relay.QL`
      fragment on Viewer {
        pool(model_id: $model_id) {
          id
        }
      }
    `
  }
})
