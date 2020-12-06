import React from 'react';
import PokemonIndexItem from './pokemon_index_item';
import { Route } from 'react-router-dom';
import PokemonFormContainer from './pokemon_form_container';
import LoadingIcon from './loading_icon';

class PokemonIndex extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    this.props.requestAllPokemon();
  }

  render() {
    if (this.props.loading) {
      return <LoadingIcon />;
    }

    const { pokemon } = this.props;
    const pokemonItems = pokemon.map((poke) => (
      <PokemonIndexItem key={poke.id} pokemon={poke} />
    ));

    return (
      <>
        <section className="pokedex">
          <ul>{pokemonItems}</ul>
        </section>
        <Route exact path="/" component={PokemonFormContainer} />
      </>
    );
  }
}

export default PokemonIndex;
