import React from 'react';
import TodoDetailViewContainer from './todo_detail_view_container';

const TodoListItem = ({ todo, removeTodo, receiveTodo }) => {
  const [detail, setDetail] = React.useState(false);

  const toggleDone = () => {
    receiveTodo(Object.assign({}, todo, { done: !todo.done }));
  };

  const toggleDetails = () => {
    setDetail(!detail);
  };

  const { title, done } = todo;
  const buttonText = todo.done ? 'Undo' : 'Done';

  return (
    <li className="todo-list-item">
      <div className="todo-header">
        <h3>
          <a onClick={toggleDetails}>{title}</a>
        </h3>
        &nbsp;
        {/* <button onClick={() => removeTodo(todo)}>Delete</button> */}
        &nbsp;
        <button className={done ? 'done' : 'undone'} onClick={toggleDone}>
          {buttonText}
        </button>
      </div>
      {detail && <TodoDetailViewContainer todo={todo} />}
    </li>
  );
};

export default TodoListItem;
