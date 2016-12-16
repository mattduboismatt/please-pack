import React from 'react'
import Relay from 'react-relay'

import ContestantRow from 'components/contestant_row'

class ContestantsList extends React.Component {
  render() {
    let { admin } = this.props
    let contestants = this.props.contestants.edges.map(contestant => contestant.node)

    return (
      <div className='contestants-list'>
        <h3>Contestants</h3>
        {contestants.map(contestant => <ContestantRow key={contestant.id} contestant={contestant} admin={admin} />)}
      </div>
    )
  }
}

export default Relay.createContainer(ContestantsList, {
  fragments: {
    contestants: () => Relay.QL`
      fragment on ContestantConnection {
        edges {
          node {
            id
            ${ContestantRow.getFragment('contestant')}
          }
        }
      }
    `
  }
})
