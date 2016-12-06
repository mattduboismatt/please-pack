import React from 'react'
import Relay from 'react-relay'

class EntryLayout extends React.Component {
  render() {
    let { entry } = this.props.viewer

    return (
      <div className='entry'>
        <h2>Entry: {entry.name}</h2>
        <h2>Points: {entry.points}</h2>
        {this.props.children}
      </div>
    )
  }
}

export default Relay.createContainer(EntryLayout, {
  initialVariables: {
    model_id: null
  },

  fragments: {
    viewer: () => Relay.QL`
      fragment on Viewer {
        entry(model_id: $model_id) {
          id
          model_id
          name
          points
        }
      }
    `
  }
})
