import React from 'react'
import Relay from 'react-relay'

import CreatePoolMutation from 'mutations/create_pool'

export default class CreatePoolForm extends React.Component {
  state = { value: '' }

  handleChange = (e) => {
    this.setState({value: e.target.value})
  }

  handleSubmit = () => {
    let mutation = new CreatePoolMutation({ viewer: this.props.viewer, pool_title: this.state.value})
    Relay.Store.commitUpdate(mutation, {
      onSuccess: this.createSuccess,
      onFailure: this.createError
    })
  }

  createSuccess = () => {
    this.setState({ value: '' })
  }

  createError = (error) => {
    console.log(error.getError())
  }

  render() {
    return (
      <div className='create-pool'>
        <input id='pool_title' type='text' value={this.state.value} onChange={this.handleChange} placeholder="Enter Pool Title" />
        <button onClick={this.handleSubmit}>Create Pool</button>
      </div>
    )
  }
}
