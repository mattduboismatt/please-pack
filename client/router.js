import React, { Component } from 'react'
import Relay from 'react-relay'
import { Router, Route, IndexRoute, browserHistory, applyRouterMiddleware } from 'react-router'
import useRelay from 'react-router-relay'

import App from 'layouts/app'
import Layout from 'layouts/layout'
import Pools from 'pages/pools'
import Admin from 'pages/admin'

const Empty = () => null

export default function AppRouter () {
  return (
    <Router history={browserHistory} render={applyRouterMiddleware(useRelay)} environment={Relay.Store}>
      <Route path='/' component={App}>
        <Route component={Layout}>
          <IndexRoute component={Pools} />
          <Route path='admin' component={Admin} />
          <Route path='*' component={Empty} />
        </Route>
      </Route>
    </Router>
  )
}
