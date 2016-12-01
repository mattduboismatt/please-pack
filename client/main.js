import React from 'react'
import ReactDOM from 'react-dom'
import Relay from 'react-relay'

import AppRouter from 'router'

Relay.injectNetworkLayer(
  new Relay.DefaultNetworkLayer('/graphql')
)

ReactDOM.render(AppRouter(), document.getElementById('main'))
