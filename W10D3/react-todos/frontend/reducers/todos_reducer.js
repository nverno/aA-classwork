import {
  RECEIVE_TODO,
  RECEIVE_TODOS,
  REMOVE_TODO,
} from '../actions/todo_actions';

const initialState = {
  1: {
    id: 1,
    title: 'wash car',
    body: 'with soap',
    done: false,
  },
  2: {
    id: 2,
    title: 'wash dog',
    body: 'with shampoo',
    done: true,
  },
};

const todosReducer = (state = initialState, action) => {
  Object.freeze(state);
  let res;

  switch (action.type) {
    case RECEIVE_TODOS:
      res = {};
      for (let todo of action.todos) {
        res[todo.id] = todo;
      }
      return res;

    case RECEIVE_TODO:
      res = Object.assign({}, state);
      res[action.todo.id] = action.todo;
      return res;

    case REMOVE_TODO:
      res = Object.assign({}, state);
      delete res[action.todo.id];
      return res;

    default:
      return state;
  }
};

export default todosReducer;
