import React from 'react'
import Relay from 'react-relay'

class PoolLayout extends React.Component {
  render() {
    let { pool } = this.props.viewer

    return (
      <div className='pool'>
        <h2>{pool.title}</h2>
        {this.props.children}
      </div>
    )
  }
}

export default Relay.createContainer(PoolLayout, {
  initialVariables: {
    model_id: null
  },

  fragments: {
    viewer: () => Relay.QL`
      fragment on Viewer {
        pool(model_id: $model_id) {
          title
        }
      }
    `
  }
})
