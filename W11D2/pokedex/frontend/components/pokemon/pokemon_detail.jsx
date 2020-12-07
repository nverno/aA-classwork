import React from 'react';
import Item from '../items/item';
import { Route, Link } from 'react-router-dom';
import ItemDetailContainer from '../items/item_detail_container';
import LoadingIcon from './loading_icon';

class PokemonDetail extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    this.props.requestPokemon(this.props.match.params.pokemonId);
  }

  componentDidUpdate(prevProps) {
    let pokemonId = this.props.match.params.pokemonId;
    if (pokemonId !== prevProps.match.params.pokemonId) {
      this.props.requestPokemon(pokemonId);
    }
  }

  render() {
    if (this.props.loading) {
      return (
        <section className="pokemon-detail">
          <LoadingIcon />
        </section>
      );
    }
    const { pokemon, moves, items } = this.props;
    if (!pokemon) return null;
    const { name, pokeType, attack, defense } = pokemon;
    // const listMoves = [];
    // moves.forEach(move => listMoves.push(move.name));
    return (
      <section className="pokemon-detail">
        <figure>
          <img src={pokemon.imageUrl} />
        </figure>
        <ul>
          <h3>{name}</h3>
          <p>Type: {pokeType}</p>
          <p>Attack: {attack}</p>
          <p>Defense: {defense}</p>
          <p>Moves: {moves.join(', ')}</p>
        </ul>
        <section className="toys">
          <h3>Items</h3>
          <ul className="toy-list">
            {items.map((item, idx) => (
              <Item key={idx} item={item} />
            ))}
          </ul>
        </section>

        <Link to={`/pokemon/${pokemon.id}/edit`}>Edit</Link>
        <Route
          path="/pokemon/:pokemonId/item/:itemId"
          component={ItemDetailContainer}
        />
      </section>
    );
  }
}

export default PokemonDetail;
