import { uniqueId } from '../../util/id_generator';
import React from 'react';
import ErrorList from './error_list';

class TodoForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      title: '',
      body: '',
      done: false,
      tag_names: [],
      newTag: '',
    };

    this.handleSubmit = this.handleSubmit.bind(this);
  }

  update(property) {
    return (e) => this.setState({ [property]: e.target.value });
  }

  addTag(e) {
    this.setState({
      tag_names: [...this.state.tag_names, this.state.newTag],
      newTag: '',
    });
  }

  removeTag(idx) {
    this.setState({
      tag_names: this.state.tag_names.filter((_, i) => i !== idx),
    });
  }

  handleSubmit(e) {
    e.preventDefault();
    const todo = Object.assign({}, this.state);
    delete todo.newTag;
    this.props.createTodo({ todo }).then(
      // reset form
      () => this.setState({ title: '', body: '', tag_names: [] })
    );
  }

  render() {
    const { title, body, tag_names, newTag } = this.state;
    const tagList = tag_names.map((tag, idx) => {
      const clickHandler = () => this.removeTag(idx);
      return (
        <li key={idx} onClick={clickHandler}>
          {tag}
        </li>
      );
    });

    return (
      <>
        <form className="todo-form" onSubmit={this.handleSubmit}>
          <ErrorList errors={this.props.errors} />
          <label>
            Title:
            <input
              className="input"
              ref="title"
              value={title}
              placeholder="buy milk"
              onChange={this.update('title')}
              required
            />
          </label>
          <label>
            Body:
            <textarea
              className="input"
              ref="body"
              cols="20"
              value={body}
              rows="5"
              placeholder="2% or whatever is on sale!"
              onChange={this.update('body')}
              required
            ></textarea>
          </label>
          <br />
          <label>
            <input
              className="input"
              placeholer="Enter a new tag"
              onChange={this.update('newTag')}
              value={newTag}
            />
            <button
              type="button"
              className="button"
              onClick={this.addTag.bind(this)}
            >
              Add Tag
            </button>
          </label>
          <ul className="tag-list">{tagList}</ul>
          <br />
          <button className="create-button">Create Todo!</button>
        </form>
      </>
    );
  }
}

export default TodoForm;
