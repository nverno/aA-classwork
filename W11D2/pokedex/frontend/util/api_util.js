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

export const createPokemon = (pokemon) =>
  $.ajax({
    method: 'POST',
    url: '/api/pokemon',
    data: { pokemon },
  });

export const updatePokemon = (pokemon) =>
  $.ajax({
    method: 'PATCH',
    url: `/api/pokemon/${pokemon.id}/edit`,
    data: { pokemon },
  });
