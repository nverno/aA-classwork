export const fetchAllPokemon = () => {
  return $.ajax({
    url: 'api/pokemon',
  });
};

export const fetchPokemon = (pokemonId) => {
  return $.ajax({
    url: `api/pokemon/${pokemonId}`,
  });
};
