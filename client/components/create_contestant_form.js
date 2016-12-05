import React from 'react'
import Relay from 'react-relay'

import CreateContestantMutation from 'mutations/create_contestant'

export default class CreateContestantForm extends React.Component {
  handleSubmit = () => {
    let mutation = new CreateContestantMutation({
      pool_id: this.props.pool.id,
      first_name: this.refs.first_name.value,
      last_name: this.refs.last_name.value,
      residence: this.refs.residence.value,
      description: this.refs.description.value,
    })

    Relay.Store.commitUpdate(mutation, {
      onSuccess: this.handleSuccess(this),
      onFailure: this.handleFailure
    })
  }

  handleSuccess = () => {
    this.refs.first_name.value = ""
    this.refs.last_name.value = ""
    this.refs.residence.value = ""
    this.refs.description.value = ""
  }

  handleFailure = (error) => {
    console.log(error.getError().source.errors[0].message)
  }


  render() {
    return (
      <div className='create-contestant'>
        <input id='first_name' ref='first_name' type='text' placeholder="First Name" />
        <input id='last_name' ref='last_name' type='text' placeholder="Last Name" />
        <input id='residence' ref='residence' type='text' placeholder="Residence" />
        <input id='description' ref='description' type='text' placeholder="Description" />
        <button onClick={this.handleSubmit}>Create Contestant</button>
      </div>
    )
  }
}
