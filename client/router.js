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

const ListsQueries = {
  lists: () => Relay.QL`query { lists }`
}

const PoolStandingsQueries = {
  pool: () => Relay.QL`query { pool(model_id: $poolId) }`,
}

export default function AppRouter () {
  return (
    <Router history={browserHistory} render={applyRouterMiddleware(useRelay)} environment={Relay.Store}>
      <Route path='/' component={App}>
        <Route component={Layout} >
          <IndexRoute component={Pools} queries={ListsQueries} />
          <Route path='pools/:poolId' component={PoolStandings} queries={PoolStandingsQueries} />
          <Route path='admin' component={Admin} queries={ListsQueries} />
          <Route path='*' component={Empty} />
        </Route>
      </Route>
    </Router>
  )
}
