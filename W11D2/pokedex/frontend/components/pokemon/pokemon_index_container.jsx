import { connect } from 'react-redux';
import { requestAllPokemon } from '../../actions/pokemon_actions';
import PokemonIndex from './pokemon_index';
import { selectAllPokemon } from '../../reducers/selectors';

const mapStateToProps = (state) => ({
  pokemon: selectAllPokemon(state),
  loading: state.ui.loading.loading,
});

const mapDispatchToProps = (dispatch) => ({
  requestAllPokemon: () => dispatch(requestAllPokemon()),
});

export default connect(mapStateToProps, mapDispatchToProps)(PokemonIndex);
