import React, { Component } from 'react'
import Relay from 'react-relay'
import { Router, Route, IndexRoute, browserHistory, applyRouterMiddleware } from 'react-router'
import useRelay from 'react-router-relay'

import App from 'layouts/app'
import Layout from 'layouts/layout'
import Pools from 'components/pools'
import PoolStandings from 'components/pool_standings'
import Admin from 'components/admin'

const Empty = () => null

const ViewerQueries = {
  viewer: () => Relay.QL`query { viewer }`
}

const preparePoolParams = (params, { location }) => {
  return { model_id: params.poolId }
}

export default function AppRouter () {
  return (
    <Router history={browserHistory} render={applyRouterMiddleware(useRelay)} environment={Relay.Store}>
      <Route path='/' component={App}>
        <Route component={Layout} >
          <IndexRoute component={Pools} queries={ViewerQueries} />
          <Route path='pools/:poolId' component={PoolStandings} queries={ViewerQueries} prepareParams={preparePoolParams} />
          <Route path='admin' component={Admin} queries={ViewerQueries} />
          <Route path='*' component={Empty} />
        </Route>
      </Route>
    </Router>
  )
}
