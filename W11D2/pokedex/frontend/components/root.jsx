import React from 'react';
import { Provider } from 'react-redux';
import PokemonIndexContainer from './pokemon/pokemon_index_container';
import { HashRouter, Route } from 'react-router-dom';
import PokemonDetailContainer from './pokemon/pokemon_detail_container';
// import ItemDetailContainer from './items/item_detail_container';
import EditPokemonFormContainer from './pokemon/edit_pokemon_form_container';

const Root = ({ store }) => (
  <Provider store={store}>
    <HashRouter>
      <Route path="/" component={PokemonIndexContainer} />
      <Route path="/pokemon/:pokemonId" component={PokemonDetailContainer} />
      <Route
        path="/pokemon/:pokemonId/edit"
        component={EditPokemonFormContainer}
      />
      {/* <Route */}
      {/*   path="/pokemon/:pokemonId/item/:itemId" */}
      {/*   component={ItemDetailContainer} */}
      {/* /> */}
    </HashRouter>
  </Provider>
);

export default Root;
