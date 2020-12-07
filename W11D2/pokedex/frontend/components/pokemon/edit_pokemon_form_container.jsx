import React, { Component } from 'react';
import { connect } from 'react-redux';
import PokemonForm from './pokemon_form';
import { updatePokemon, requestPokemon } from '../../actions/pokemon_actions';

const mapStateToProps = (state, ownProps) => ({
  pokemon: state.entities.pokemon[ownProps.match.params.pokemonId],
  errors: state.ui.errors,
  formType: 'Update Pokemon',
});

const mapDispatchToProps = (dispatch) => ({
  requestPokemon: (id) => dispatch(requestPokemon(id)),
  action: (poke) => dispatch(updatePokemon(poke)),
});

class EditPokemonForm extends Component {
  componentDidMount() {
    this.props.requestPokemon(this.props.match.params.pokemonId);
  }

  render() {
    const { errors, action, formType, pokemon } = this.props;
    if (!pokemon) return null;
    return (
      <PokemonForm
        errors={errors}
        action={action}
        formType={formType}
        pokemon={pokemon}
      />
    );
  }
}
export default connect(mapStateToProps, mapDispatchToProps)(EditPokemonForm);
