import { connect } from 'react-redux';
import ItemDetail from './item_detail';

const msp = (state, ownProps) => ({
  item: state.entities.items[ownProps.match.params.itemId],
});

const mdp = (dispatch) => ({});

export default connect(msp, mdp)(ItemDetail);
