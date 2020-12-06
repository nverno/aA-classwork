export const selectAllPokemon = (state) =>
  // { pokemon: { 1: { ... }, 2: ... }}
  Object.values(state.entities.pokemon);
