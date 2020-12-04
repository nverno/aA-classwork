import { connect } from 'react-redux';
import Greeting from './greeting';
import { logout } from '../../actions/session_actions';

const mapStateToProps = ({ entities, session }, ownProps) => ({
  currentUser: entities.users[session.id],
});

const mapDispatchToProps = (dispatch) => ({
  logout: () => dispatch(logout()),
});

export default connect(mapStateToProps, mapDispatchToProps)(Greeting);
