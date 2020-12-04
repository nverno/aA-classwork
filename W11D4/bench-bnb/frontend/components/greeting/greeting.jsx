import React, { Component } from 'react';
import { Link } from 'react-router-dom';

export default class Greeting extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    const { currentUser, logout } = this.props;
    const greeting = currentUser ? (
      <div className="greeting">
        <div>Welcome, {currentUser.username}</div>
        <button onClick={logout}>Logout</button>
      </div>
    ) : (
      <div>
        <Link to="/signup">Sign Up</Link> | <Link to="/login">Login</Link>
      </div>
    );
    return greeting;
  }
}
