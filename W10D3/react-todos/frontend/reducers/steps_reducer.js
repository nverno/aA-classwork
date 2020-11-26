import {
  RECEIVE_STEP,
  RECEIVE_STEPS,
  REMOVE_STEP,
} from '../actions/step_actions';

const initialState = {
  1: {
    id: 1,
    title: 'walk to store',
    done: false,
    todo_id: 1,
  },
  2: {
    id: 2,
    title: 'buy soap',
    done: false,
    todo_id: 1,
  },
  3: {
    id: 3,
    title: 'walk to park',
    done: false,
    todo_id: 3,
  },
  4: {
    id: 4,
    title: 'play with dog',
    done: false,
    todo_id: 2,
  },
};

const stepsReducer = (state = initialState, action) => {
  Object.freeze(state);
  let res;

  switch (action.type) {
    case RECEIVE_STEP:
      return Object.assign({}, state, { [action.step.id]: action.step });

    case RECEIVE_STEPS:
      res = Object.assign({}, state);
      action.steps.action.steps.forEach(function (step) {
        res[step.id] = step;
      });
      return res;

    case REMOVE_STEP:
      res = Object.assign({}, state);
      delete res[action.step.id];
      return res;

    default:
      return state;
  }
};

export default stepsReducer;
