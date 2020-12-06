import { RECEIVE_POKEMON } from '../actions/pokemon_actions';

const movesReducer = (state = {}, action) => {
  Object.freeze(state);

  switch (action.type) {
    case RECEIVE_POKEMON:
      let nextState = action.pokemon.moves;
      // Object.values(action.pokemon.items)
      //     .map(item => nextState[item.id] = item);
      return nextState;

    default:
      return state;
  }
};

export default movesReducer;
