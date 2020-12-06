import React, { Component } from 'react';

const pokeTypes = [
  'fire',
  'electric',
  'normal',
  'ghost',
  'psychic',
  'water',
  'bug',
  'dragon',
  'grass',
  'fighting',
  'ice',
  'flying',
  'poison',
  'ground',
  'rock',
  'steel',
];

const emptyForm = {
  name: '',
  attack: '',
  defense: '',
  image_url: '',
  poke_type: 'fire',
};

export default class PokemonForm extends Component {
  constructor(props) {
    super(props);
    this.state = { ...emptyForm };
  }

  handleChange(property) {
    return (e) => this.setState({ [property]: e.target.value });
  }

  handleSubmit(e) {
    e.preventDefault();
    this.props.createPokemon(this.state).then((poke) => {
      let id = Object.keys(poke.pokemon)[0];
      this.props.history.push(`pokemon/${id}`);
    });
    // this.setState({ ...emptyForm });
  }

  errors() {
    return this.props.errors.map((error) => (
      <li className="error" key={error}>
        {error}
      </li>
    ));
  }

  render() {
    const { name, attack, defense, poke_type, image_url } = this.state;
    return (
      <section className="pokemon-detail">
        <ul>{this.errors()}</ul>
        <form className="pokemon-form" onSubmit={this.handleSubmit.bind(this)}>
          <label>
            Name
            <input
              type="text"
              className="input"
              value={name}
              onChange={this.handleChange('name')}
            />
          </label>
          <label>
            Attack
            <input
              type="number"
              className="input"
              value={attack}
              onChange={this.handleChange('attack')}
            />
          </label>
          <label>
            Defense
            <input
              type="number"
              className="input"
              value={defense}
              onChange={this.handleChange('defense')}
            />
          </label>
          <label>
            Image URL
            <input
              type="text"
              className="input"
              value={image_url}
              onChange={this.handleChange('image_url')}
            />
          </label>
          <label>
            Pokemon Type
            <select
              /* defaultValue="Select Type" */
              onChange={this.handleChange('poke_type')}
              value={poke_type}
            >
              {pokeTypes.map((type, idx) => (
                <option value={type} key={idx}>
                  {type}
                </option>
              ))}
            </select>
          </label>
          <br />
          <button type="submit">Submit</button>
        </form>
      </section>
    );
  }
}
