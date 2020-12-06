import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';

import Root from './components/root';

import { fetchTodos, createTodo } from './actions/todo_actions';

document.addEventListener('DOMContentLoaded', () => {
  const preloadedState = localStorage.state
    ? JSON.parse(localStorage.state)
    : {};
  const store = configureStore(preloadedState);

  const root = document.getElementById('content');
  ReactDOM.render(<Root store={store} />, root);

  window.fetchTodos = fetchTodos;
  window.store = store;
  window.createTodo = createTodo;
});
// ch
