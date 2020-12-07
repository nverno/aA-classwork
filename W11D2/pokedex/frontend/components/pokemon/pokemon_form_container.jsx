import { connect } from 'react-redux';
import PokemonForm from './pokemon_form';
import { createPokemon } from '../../actions/pokemon_actions';

const mapStateToProps = (state, ownProps) => ({
  formType: 'Create Pokemon',
  errors: state.ui.errors,
  pokemon: {
    name: '',
    attack: '',
    defense: '',
    image_url: '',
    poke_type: 'fire',
  },
});

const mapDispatchToProps = (dispatch) => ({
  action: (poke) => dispatch(createPokemon(poke)),
});

export default connect(mapStateToProps, mapDispatchToProps)(PokemonForm);
