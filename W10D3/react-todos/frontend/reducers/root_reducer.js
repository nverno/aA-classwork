import { combineReducers } from 'redux';
import todosReducer from './todos_reducer';
import stepsReducer from './steps_reducer';

const rootReducer = combineReducers({
  todos: todosReducer,
  steps: stepsReducer,
});

// window.rootReducer = rootReducer;
window.stepsReducer = stepsReducer;

export default rootReducer;
