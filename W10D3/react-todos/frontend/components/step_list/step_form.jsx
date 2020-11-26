import React, { Component } from 'react';
import { uniqueId } from '../../util/utils';

class StepForm extends Component {
  constructor(props) {
    super(props);
    this.state = {
      title: '',
      body: '',
      todo_id: props.todo_id,
      done: false,
    };
  }

  handleSubmit(e) {
    e.preventDefault();
    const step = Object.assign({}, this.state, { id: uniqueId() });
    this.props.receiveStep(step);
    this.setState({
      title: '',
      body: '',
    });
  }

  handleChange(key, e) {
    e.preventDefault();
    this.setState({ [key]: e.target.value });
  }

  render() {
    const { title, body } = this.state;
    return (
      <form className="step-form" onSubmit={this.handleSubmit.bind(this)}>
        <label>
          Title:
          <input
            type="text"
            className="input"
            value={title}
            onChange={this.handleChange.bind(this, 'title')}
            placeholder="body movin'"
            required
          />
        </label>
        <br />
        <label>
          Body:
          <textarea
            className="input"
            value={body}
            onChange={this.handleChange.bind(this, 'body')}
            cols="20"
            rows="5"
            placeholder="aint one sound that could sound so soothin"
            required
          ></textarea>
        </label>
        <br />

        <button className="create-button">Create</button>
      </form>
    );
  }
}

export default StepForm;
