import React from 'react';
import { connect } from 'react-redux';
import SessionForm from './session_form';
import { signup } from '../../actions/session_actions';
import { Link } from 'react-router-dom';

const mapStateToProps = ({ errors }, _ownProps) => ({
  formType: 'signup',
  errors: errors.session,
  navLink: <Link to="/login">Login</Link>,
});

const mapDispatchToProps = (dispatch) => ({
  processForm: (user) => dispatch(signup(user)),
});

export default connect(mapStateToProps, mapDispatchToProps)(SessionForm);
