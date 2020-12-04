import React, { Component } from 'react';

export default class SessionForm extends Component {
  constructor(props) {
    super(props);
    this.state = {
      username: '',
      password: '',
    };
  }

  handleChange(key) {
    return (e) => {
      this.setState({ [key]: e.target.value });
    };
  }

  handleSubmit(e) {
    e.preventDefault();
    const user = Object.assign({}, this.state);
    this.props.processForm(user);
    this.setState({ username: '', password: '' });
  }

  render() {
    const { formType, errors, navLink } = this.props;
    const { username, password } = this.state;
    // const link = formType === 'login' ? '/signup' : '/login';
    // const linkText = formType === 'login' ? 'Sign Up' : 'Login';
    return (
      <div className="login-form-container">
        <ul>
          {errors.map((err, idx) => (
            <li key={`error-${idx}`} className="error">
              <p>{err}</p>
            </li>
          ))}
        </ul>
        <br />
        <h2>{formType}</h2>
        <form onSubmit={this.handleSubmit.bind(this)}>
          <label>
            Username
            <input
              type="text"
              className="input"
              value={username}
              onChange={this.handleChange('username')}
            />
          </label>
          <label>
            Password
            <input
              type="password"
              className="input"
              value={password}
              onChange={this.handleChange('password')}
            />
          </label>
          <button>{formType}</button>
          <br />
          {navLink}
        </form>
      </div>
    );
  }
}
