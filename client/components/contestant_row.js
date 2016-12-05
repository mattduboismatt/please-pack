import React from 'react'

export default class ContestantRow extends React.Component {
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
