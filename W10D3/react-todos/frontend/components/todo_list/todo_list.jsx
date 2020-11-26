import React from 'react';
import TodoListItem from './todo_list_item';
import TodoForm from './todo_form';

const TodoList = ({ todos, receiveTodo, removeTodo }) => {
  return (
    <div>
      <ul className="todo-list">
        {todos.map((todo, idx) => (
          <TodoListItem
            key={idx}
            todo={todo}
            receiveTodo={receiveTodo}
            removeTodo={removeTodo}
          />
        ))}
      </ul>
      <br />
      <TodoForm receiveTodo={receiveTodo} />
    </div>
  );
};

export default TodoList;
