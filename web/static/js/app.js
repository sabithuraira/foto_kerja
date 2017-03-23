// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

import React from 'react'
import { createStore } from 'redux';
import { render } from 'react-dom'
import { Provider } from 'react-redux'

import appReducers from './react/reducers/appReducers'
import AppContainer from './react/containers/AppContainer'

let store = createStore(appReducers)
/*
const configureStore = (props) => (
  createStore(appReducer, props)
);
const ListPkApp = (props, _railsContext) => (
  <Provider store={configureStore(props)}>
    <ListPkContainer />
  </Provider>
);
*/
render(
    <Provider store={store}>
        <AppContainer />
    </Provider>,
    document.getElementById('reactdom')
)