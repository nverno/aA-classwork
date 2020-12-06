export const selectAllPokemon = (state) =>
  // { pokemon: { 1: { ... }, 2: ... }}
  Object.values(state.entities.pokemon);

export const selectPokemonMovesNames = (state) =>
  Object.values(state.entities.moves).map((move) => move.name);
