import React from 'react'
import Relay from 'react-relay'

import EntryPicksForm from 'components/entry_picks_form'

class EntryPicks extends React.Component {
  render() {
    return (
      <div className='picks'>
        <p>Picks</p>
        <EntryPicksForm entry={this.props.viewer.entry} />
      </div>
    )
  }
}

export default Relay.createContainer(EntryPicks, {
  initialVariables: {
    model_id: null
  },

  fragments: {
    viewer: () => Relay.QL`
      fragment on Viewer {
        entry(model_id: $model_id) {
          ${EntryPicksForm.getFragment('entry')}
        }
      }
    `
  }
})
