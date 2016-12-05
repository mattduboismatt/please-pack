import React from 'react'

import ContestantRow from 'components/contestant_row'

export default class ContestantsList extends React.Component {
  render() {
    let { contestants } = this.props

    return (
      <div className='contestants-list'>
        {contestants.map(contestant => <ContestantRow key={contestant.id} contestant={contestant} />)}
      </div>
    )
  }
}
