import { connect } from 'react-redux';
import { requestPokemon } from '../../actions/pokemon_actions';
import PokemonDetail from './pokemon_detail';
import { selectPokemonMovesNames } from '../../reducers/selectors';

const mapStateToProps = (state, ownProps) => {
  // debugger;
  const currPoke = state.entities.pokemon[ownProps.match.params.pokemonId];
  return {
    pokemon: currPoke,
    moves: selectPokemonMovesNames(state),
    items: Object.values(state.entities.items),
    loading: state.ui.loading.loading,
  };
};

const mapDispatchToProps = (dispatch) => ({
  requestPokemon: (pokemon) => dispatch(requestPokemon(pokemon)),
});

export default connect(mapStateToProps, mapDispatchToProps)(PokemonDetail);
