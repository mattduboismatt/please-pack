import React from 'react'
import Relay from 'react-relay'

import CreateEntryMutation from 'mutations/create_entry'

export default class CreateEntryForm extends React.Component {
  state = { value: '' }

  handleChange = (e) => {
    this.setState({ value: e.target.value })
  }

  handleSubmit = () => {
    let mutation = new CreateEntryMutation({
      pool: this.props.pool,
      name: this.state.value
    })

    Relay.Store.commitUpdate(mutation, {
      onSuccess: this.handleSuccess,
      onFailure: this.handleFailure
    })
  }

  handleSuccess = () => {
    this.setState({ value: '' })
  }

  handleFailure = (error) => {
    console.log(error.getError().source.errors[0].message)
  }

  render() {
    return (
      <div className='create-entry'>
        <input id='entry_name' type='text' value={this.state.value} onChange={this.handleChange} placeholder="Entry Name" />
        <button onClick={this.handleSubmit}>Create Entry</button>
      </div>
    )
  }
}
