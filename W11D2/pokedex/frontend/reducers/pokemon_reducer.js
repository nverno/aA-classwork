import {
  RECEIVE_ALL_POKEMON,
  RECEIVE_POKEMON,
} from '../actions/pokemon_actions';

const pokemonReducer = (state = {}, action) => {
  Object.freeze(state);
  let nextState = Object.assign({}, state);

  switch (action.type) {
    case RECEIVE_ALL_POKEMON:
      return action.pokemon;
    case RECEIVE_POKEMON:
      // action.pokemon = { 1: { ... } }
      let id = Object.keys(action.pokemon.pokemon)[0];
      nextState[id] = Object.values(action.pokemon.pokemon)[0];
      return nextState;
    default:
      return state;
  }
};

export default pokemonReducer;
