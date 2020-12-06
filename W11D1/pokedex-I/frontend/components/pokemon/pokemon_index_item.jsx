import React from 'react';
import { Link } from 'react-router-dom';

const PokemonIndexItem = ({ pokemon }) => {
  return (
    <li key={`pokemon-index-item-${pokemon.id}`}>
      <Link
        key={`pokemon-index-link-${pokemon.id}`}
        to={`/pokemon/${pokemon.id}`}
      >
        {pokemon.id}
        &nbsp;
        <img src={pokemon.imageUrl} width="20" /> {pokemon.name}
      </Link>
    </li>
  );
};

export default PokemonIndexItem;
