import React from 'react';
import ReactDOM from 'react-dom';
import Root from './components/root';

import { configureStore } from './store/store';
import { receiveTodo, receiveTodos } from './actions/todo_actions';
import { receiveStep, receiveSteps } from './actions/step_actions';

import { allTodos, allSteps, stepsByTodoId } from './reducers/selectors';

const store = configureStore();

document.addEventListener('DOMContentLoaded', () => {
  const content = document.getElementById('content');
  ReactDOM.render(<Root store={store} />, content);
});

window.store = store;
window.receiveTodo = receiveTodo;
window.receiveTodos = receiveTodos;
window.allTodos = allTodos;
window.allSteps = allSteps;
window.stepsByTodoId = stepsByTodoId;
