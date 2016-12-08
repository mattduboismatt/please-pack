import React from 'react'
import Relay from 'react-relay'

import SavePicksMutation from 'mutations/save_picks'
import Checkbox from 'shared/checkbox'

class EntryPicksForm extends React.Component {
  static contextTypes = {
    router: React.PropTypes.object.isRequired
  }

  componentWillMount() {
    let pickedContestantIds = this.props.entry.picks.map(pick => pick.contestant.model_id)
    this.selectedCheckboxes = new Set(pickedContestantIds)
  }

  toggleCheckbox = (contestantId) => {
    if (this.selectedCheckboxes.has(contestantId)) {
      this.selectedCheckboxes.delete(contestantId)
    } else {
      this.selectedCheckboxes.add(contestantId)
    }
  }

  handleSubmit = (e) => {
    e.preventDefault()
    let mutation = new SavePicksMutation({
      entry: this.props.entry,
      contestant_ids: [...this.selectedCheckboxes]
    })

    Relay.Store.commitUpdate(mutation, {
      onSuccess: this.handleSuccess,
      onFailure: this.handleFailure
    })
  }

  handleSuccess = () => {
    let poolSetupPath = `/pools/${this.props.entry.pool.model_id}/setup`
    this.context.router.push(poolSetupPath)
  }

  handleFailure = (error) => {
    console.log(error.getError().source.errors[0].message)
  }

  createCheckbox = (contestant) => {
    let modelId = contestant.model_id
    let isChecked = this.selectedCheckboxes.has(modelId)

    return (
      <Checkbox
        key={contestant.id}
        label={contestant.first_name}
        modelId={modelId}
        handleCheckboxChange={this.toggleCheckbox}
        isChecked={isChecked}
      />
    )
  }

  createCheckboxes = () => {
    let contestants = this.props.entry.pool.contestants.edges.map(contestant => contestant.node)
    return contestants.map(contestant => this.createCheckbox(contestant))
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
        {this.createCheckboxes()}
        <input type='submit' value='Save' />
      </form>
    )
  }
}

export default Relay.createContainer(EntryPicksForm, {
  fragments: {
    entry: () => Relay.QL`
      fragment on Entry {
        ${SavePicksMutation.getFragment('entry')}
        picks {
          contestant {
            model_id
          }
        }
        pool {
          model_id
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
    `
  }
})
