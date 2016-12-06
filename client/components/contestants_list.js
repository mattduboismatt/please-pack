import React from 'react'

class ContestantRow extends React.Component {
  render() {
    let { contestant } = this.props

    return(
      <div className='contestant'>
        <span>{contestant.first_name}</span>
        <span>{contestant.last_name}</span>
        <span>{contestant.residence}</span>
        <span>{contestant.description}</span>
      </div>
    )
  }
}

export default class ContestantsList extends React.Component {
  render() {
    let { contestants } = this.props

    return (
      <div className='contestants-list'>
        <h3>Contestants</h3>
        {contestants.map(contestant => <ContestantRow key={contestant.id} contestant={contestant} />)}
      </div>
    )
  }
}
