import React from 'react';

class PokemonDetail extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    this.props.requestPokemon(this.props.match.params.pokemonId);
  }

  render() {
    // if (!pokemon) return null;
    const { pokemon, moves, items } = this.props;

    // const listMoves = [];
    // moves.forEach(move => listMoves.push(move.name));
    return (
      <section className="pokedex">
        <img src={pokemon.imageUrl} />
        {pokemon.name}
        Type: {pokemon.poke_type}
        Attack: {pokemon.attack}
        Defense: {pokemon.defense}
        Moves: {/*listMoves.join(', ')*/}
      </section>
    );
  }
}

export default PokemonDetail;
