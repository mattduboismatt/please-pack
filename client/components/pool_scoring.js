import React from 'react'
import Relay from 'react-relay'

import PoolScoringForm from 'components/pool_scoring_form'
import PoolAdminLinks from 'components/pool_admin_links'

class PoolScoring extends React.Component {
  render() {
    let { viewer } = this.props
    let pool = viewer.pool

    return (
      <div className='scoring'>
        <PoolAdminLinks pool={pool} />
        <PoolScoringForm viewer={viewer} pool={pool} contestants={pool.contestants} />
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
          ${PoolScoringForm.getFragment('pool')}
          contestants(first: 100) {
            ${PoolScoringForm.getFragment('contestants')}
          }
          ${PoolAdminLinks.getFragment('pool')}
        }
      }
    `
  }
})
