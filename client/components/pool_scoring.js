import React from 'react'
import Relay from 'react-relay'

import PoolScoringForm from 'components/pool_scoring_form'

class PoolScoring extends React.Component {
  render() {
    return (
      <div className='scoring'>
        <p>Scoring</p>
        <PoolScoringForm viewer={this.props.viewer} score_mechanisms={this.props.viewer.score_mechanisms} contestants={this.props.viewer.pool.contestants} />
      </div>
    )
  }
}

export default Relay.createContainer(PoolScoring, {
  initialVariables: {
    model_id: null
  },

  fragments: {
    viewer: () => Relay.QL`
      fragment on Viewer {
        score_mechanisms
        pool(model_id: $model_id) {
          contestants(first: 100) {
            ${PoolScoringForm.getFragment('contestants')}
          }
        }
      }
    `
  }
})
