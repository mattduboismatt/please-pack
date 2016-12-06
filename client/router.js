import React from 'react'
import Relay from 'react-relay'
import { Router, Route, IndexRoute, browserHistory, applyRouterMiddleware } from 'react-router'
import useRelay from 'react-router-relay'

import App from 'layouts/app'
import Layout from 'layouts/layout'
import PoolLayout from 'layouts/pool'
import EntryLayout from 'layouts/entry'
import Pools from 'components/pools'
import PoolStandings from 'components/pool_standings'
import PoolSetup from 'components/pool_setup'
import EntrySelections from 'components/entry_selections'
import Admin from 'components/admin'

const Empty = () => null

const ViewerQueries = {
  viewer: () => Relay.QL`query { viewer }`
}

const preparePoolParams = (params, { location }) => {
  return { model_id: params.poolId }
}

const prepareEntryParams = (params, { location }) => {
  return { model_id: params.entryId }
}

export default function AppRouter () {
  return (
    <Router history={browserHistory} render={applyRouterMiddleware(useRelay)} environment={Relay.Store}>
      <Route path='/' component={App}>
        <Route component={Layout} >
          <IndexRoute component={Pools} queries={ViewerQueries} />
          <Route path='pools/:poolId' component={PoolLayout} queries={ViewerQueries} prepareParams={preparePoolParams}>
            <IndexRoute component={PoolStandings} queries={ViewerQueries} />
            <Route path='setup' component={PoolSetup} queries={ViewerQueries} />
          </Route>
          <Route path='entries/:entryId' component={EntryLayout} queries={ViewerQueries} prepareParams={prepareEntryParams}>
            <Route path='selections' component={EntrySelections} queries={ViewerQueries} />
          </Route>
          <Route path='admin' component={Admin} queries={ViewerQueries} />
          <Route path='*' component={Empty} />
        </Route>
      </Route>
    </Router>
  )
}
