import React from 'react';
// Components
import TodoListItem from './todo_list_item';
import TodoForm from './todo_form';

class TodoList extends React.Component {
  componentDidMount() {
    this.props.fetchTodos();
  }

  render() {
    const {
      todos,
      errors,
      deleteTodo,
      receiveTodo,
      updateTodo,
      createTodo,
    } = this.props;

    const todoItems = todos.map((todo) => (
      <TodoListItem
        key={`todo-list-item-${todo.id}`}
        todo={todo}
        receiveTodo={receiveTodo}
        updateTodo={updateTodo}
        deleteTodo={deleteTodo}
      />
    ));

    return (
      <div>
        <TodoForm
          receiveTodo={receiveTodo}
          createTodo={createTodo}
          errors={errors}
        />
        <ul className="todo-list">{todoItems}</ul>
      </div>
    );
  }
}

export default TodoList;
