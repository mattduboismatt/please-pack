import React from 'react'
import Relay from 'react-relay'

class EntrySelectionsInputRow extends React.Component {
  render() {
    let { contestant } = this.props

    return (
      <label className='entry-selection-row'>
        <input type='checkbox' value={contestant.model_id} />
        {contestant.first_name}
      </label>
    )
  }
}

class EntrySelections extends React.Component {
  handleSubmit = (e) => {
    e.preventDefault()
  }

  render() {
    let contestants = this.props.viewer.entry.pool.contestants.edges.map(contestant => contestant.node)

    return (
      <div className='selections'>
        <p>Selections</p>
        <form onSubmit={this.handleSubmit}>
          {contestants.map(contestant => <EntrySelectionsInputRow key={contestant.id} contestant={contestant} />)}
          <input type='submit' value='Save' />
        </form>
      </div>
    )
  }
}

export default Relay.createContainer(EntrySelections, {
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
