import React, { Component } from 'react';

export default class ErrorList extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    const { errors } = this.props;
    if (errors.length === 0) return null;

    return (
      <ul className="error-list">
        {errors.map((error) => (
          <li key={error}>{error}</li>
        ))}
      </ul>
    );
  }
}
