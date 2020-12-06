import { connect } from 'react-redux';
import PokemonForm from './pokemon_form';
import { createPokemon } from '../../actions/pokemon_actions';

const mapStateToProps = (state, ownProps) => ({
  errors: state.ui.errors,
});

const mapDispatchToProps = (dispatch) => ({
  createPokemon: (poke) => dispatch(createPokemon(poke)),
});

export default connect(mapStateToProps, mapDispatchToProps)(PokemonForm);
