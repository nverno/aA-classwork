import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import Root from './components/root';

import * as actions from './actions/pokemon_actions';
import * as selectors from './reducers/selectors';
import * as API from './util/api_util';

document.addEventListener('DOMContentLoaded', () => {
  const root = document.getElementById('root');
  const store = configureStore();

  window.store = store;
  window.selectors = selectors;
  window.API = API;
  window.actions = actions;

  ReactDOM.render(<Root store={store} />, root);
});
