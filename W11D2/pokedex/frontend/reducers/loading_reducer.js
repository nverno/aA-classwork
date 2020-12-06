import {
  RECEIVE_ALL_POKEMON,
  RECEIVE_POKEMON,
  START_LOADING_ALL_POKEMON,
  START_LOADING_SINGLE_POKEMON,
} from '../actions/pokemon_actions';

export default (state = { loading: false }, action) => {
  Object.freeze(state);
  switch (action.type) {
    case RECEIVE_ALL_POKEMON:
    case RECEIVE_POKEMON:
      return Object.assign({}, state, { loading: false });

    case START_LOADING_ALL_POKEMON:
    case START_LOADING_SINGLE_POKEMON:
      return Object.assign({}, state, { loading: true });

    default:
      return state;
  }
};
