import React from 'react';
import TodoDetailViewContainer from './todo_detail_view_container';

class TodoListItem extends React.Component {
  constructor(props) {
    super(props);
    this.state = { detail: false };
    this.toggleDetail = this.toggleDetail.bind(this);
    this.toggleTodo = this.toggleTodo.bind(this);
  }

  toggleDetail(e) {
    e.preventDefault();
    this.setState({ detail: !this.state.detail });
  }

  toggleTodo(e) {
    e.preventDefault();
    const toggledTodo = Object.assign({}, this.props.todo, {
      done: !this.props.todo.done,
    });

    this.props.updateTodo(toggledTodo);
  }

  render() {
    const { todo, deleteTodo } = this.props;
    const { title, done } = todo;
    let detail;
    if (this.state.detail) {
      detail = <TodoDetailViewContainer todo={todo} />;
    }
    const tagList = (
      <ul>
        {todo.tags.map((tag, idx) => (
          <li key={idx}>{tag.name}</li>
        ))}
      </ul>
    );

    return (
      <li className="todo-list-item">
        <div className="todo-header">
          <h3>
            <a onClick={this.toggleDetail}>{title}</a>
          </h3>
          <div className="tag-list">{tagList}</div>
          <button
            className={done ? 'done' : 'undone'}
            onClick={this.toggleTodo}
          >
            {done ? 'Undo' : 'Done'}
          </button>{' '}
          <button onClick={(_e) => deleteTodo(todo)}>Delete</button>
        </div>
        {detail}
      </li>
    );
  }
}

export default TodoListItem;
