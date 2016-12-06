import React from 'react'
import Relay from 'react-relay'

class EntryPicksInputRow extends React.Component {
  render() {
    let { contestant } = this.props

    return (
      <label className='entry-pick-row'>
        <input type='checkbox' value={contestant.model_id} />
        {contestant.first_name}
      </label>
    )
  }
}

class EntryPicks extends React.Component {
  handleSubmit = (e) => {
    e.preventDefault()
  }

  render() {
    let contestants = this.props.viewer.entry.pool.contestants.edges.map(contestant => contestant.node)

    return (
      <div className='picks'>
        <p>Picks</p>
        <form onSubmit={this.handleSubmit}>
          {contestants.map(contestant => <EntryPicksInputRow key={contestant.id} contestant={contestant} />)}
          <input type='submit' value='Save' />
        </form>
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
          id
          model_id
          pool {
            contestants(first: 100) {
              edges {
                node {
                  id
                  model_id
                  first_name
                }
              }
            }
          }
        }
      }
    `
  }
})
