import React, { Component } from 'react';
import { uniqueId } from '../../util/utils';

/** Form to create a new todo entry:
 * - title <string>
 * - body <text>
 * - done <bool>
 *
 * Receives `receiveTodo` callback in props to add new todo
 */
export default class TodoForm extends Component {
  constructor(props) {
    super(props);
    this.state = {
      title: '',
      body: '',
      done: false,
    };
  }

  handleChange(key, e) {
    this.setState({ [key]: e.target.value });
  }

  handleSubmit(e) {
    e.preventDefault();
    const todo = Object.assign({}, this.state, { id: uniqueId() });
    this.props.receiveTodo(todo);
    this.setState({
      title: '',
      body: '',
    });
  }

  render() {
    const { title, body } = this.state;

    return (
      <form className="todo-form" onSubmit={this.handleSubmit.bind(this)}>
        <label>
          Title:
          <input
            className="input"
            ref="title"
            value={title}
            onChange={this.handleChange.bind(this, 'title')}
          />
        </label>
        <br />

        <label>
          Body:
          <textarea
            className="input"
            ref="body"
            value={body}
            onChange={this.handleChange.bind(this, 'body')}
            rows="5"
            cols="20"
            placeholder="body movin"
            required
          ></textarea>
        </label>
        <br />

        <button className="create-button">Create</button>
      </form>
    );
  }
}
