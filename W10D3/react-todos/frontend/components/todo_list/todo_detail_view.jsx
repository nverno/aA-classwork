import React from 'react';
import StepListContainer from '../step_list/step_list_container';

const TodoDetailView = ({ todo, removeTodo }) => {
  return (
    <div className="todo-details">
      <p>{todo.body}</p>
      <StepListContainer todo_id={todo.id} />
      <button className="delete-button" onClick={() => removeTodo(todo)}>
        Delete
      </button>
    </div>
  );
};

export default TodoDetailView;
