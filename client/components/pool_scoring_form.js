import React from 'react'
import Relay from 'react-relay'
import shortid from 'shortid'

import CreateScoreMutation from 'mutations/create_score'
import CreateEliminationMutation from 'mutations/create_elimination'
import Checkbox from 'shared/checkbox'

class PoolScoringForm extends React.Component {
  state = { mechanism: '', points: "1" }

  static contextTypes = {
    router: React.PropTypes.object.isRequired
  }

  componentWillMount() {
    this.selectedCheckboxes = new Set()
  }

  toggleCheckbox = (contestantId) => {
    if (this.selectedCheckboxes.has(contestantId)) {
      this.selectedCheckboxes.delete(contestantId)
    } else {
      this.selectedCheckboxes.add(contestantId)
    }
  }

  handleMechanismChange = (e) => {
    this.setState({ mechanism: e.target.value })
  }


  handlePointsChange = (e) => {
    this.setState({ points: e.target.value })
  }

  handleSubmit = (e) => {
    e.preventDefault()
    if (this.state.mechanism === 'elimination') {
      this.handleEliminationMutation()
    } else {
      this.handleScoreMutation()
    }
  }

  handleEliminationMutation = () => {
    let mutation = new CreateEliminationMutation({
      viewer: this.props.viewer,
      points: this.state.points,
      pool: this.props.pool,
      contestant_ids: [...this.selectedCheckboxes]
    })

    this.commitMutation(mutation)
  }

  handleScoreMutation = () => {
    let mutation = new CreateScoreMutation({
      viewer: this.props.viewer,
      points: this.state.points,
      mechanism: this.state.mechanism,
      contestant_ids: [...this.selectedCheckboxes]
    })

    this.commitMutation(mutation)
  }

  commitMutation = (mutation) => {
    Relay.Store.commitUpdate(mutation, {
      onSuccess: this.handleSuccess,
      onFailure: this.handleFailure
    })
  }

  handleSuccess = () => {
    this.context.router.push('/admin')
  }

  handleFailure = (error) => {
    console.log(error.getError().source.errors[0].message)
  }

  createCheckbox = (contestant) => {
    return (
      <Checkbox
        key={contestant.id}
        label={contestant.first_name}
        modelId={contestant.model_id}
        handleCheckboxChange={this.toggleCheckbox}
        isChecked={false}
        isEliminated={contestant.eliminated}
      />
    )
  }

  createCheckboxes = () => {
    let contestants = this.props.contestants.edges.map(contestant => contestant.node)
    return contestants.map(contestant => this.createCheckbox(contestant))
  }

  createOption = (mechanism) => {
    return (
      <option value={mechanism} key={shortid.generate()}>{mechanism}</option>
    )
  }

  createMechanismSelect = () => {
    let scoreMechanisms = this.props.viewer.score_mechanisms

    return (
      <div className='select-mechanism'>
        <label htmlFor='score_mechanism'>Mechanism</label>
        <select name='score_mechanism' value={this.state.mechanism} onChange={this.handleMechanismChange}>
          <option value='' disabled>select</option>
          {scoreMechanisms.map(mechanism => this.createOption(mechanism))}
        </select>
      </div>
    )
  }

  render() {
    return (
      <form className='pool-scoring-form' onSubmit={this.handleSubmit}>
        {this.createMechanismSelect()}
        <div className='points'>
          <label htmlFor='points'>Points</label>
          <input type='number' name='points' value={this.state.points} onChange={this.handlePointsChange}/>
        </div>
        <div className='checkboxes'>{this.createCheckboxes()}</div>
        <input type='submit' value='Score' />
      </form>
    )
  }
}

export default Relay.createContainer(PoolScoringForm, {
  fragments: {
    contestants: () => Relay.QL`
      fragment on ContestantConnection {
        edges {
          node {
            id
            model_id
            first_name
            eliminated
          }
        }
      }
    `,
    pool: () => Relay.QL`
      fragment on Pool {
        model_id
      }
    `
  }
})
