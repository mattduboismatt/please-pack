import React from 'react'

export default class EntryRow extends React.Component {
  render() {
    let { entry } = this.props

    return(
      <div className='entry'>
        <span>{entry.name}</span>
        <span>{entry.points}</span>
      </div>
    )
  }
}
