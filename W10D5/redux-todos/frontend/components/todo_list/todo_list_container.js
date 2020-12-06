import { connect } from 'react-redux';
import TodoList from './todo_list';

// Actions
import {
  fetchTodos,
  receiveTodo,
  createTodo,
  updateTodo,
  deleteTodo,
} from '../../actions/todo_actions';
import { allTodos } from '../../reducers/selectors';

const mapStateToProps = (state) => ({
  todos: allTodos(state),
  errors: state.errors,
});

const mapDispatchToProps = (dispatch) => ({
  fetchTodos: () => dispatch(fetchTodos()),
  receiveTodo: (todo) => dispatch(receiveTodo(todo)),
  createTodo: (todo) => dispatch(createTodo(todo)),
  updateTodo: (todo) => dispatch(updateTodo(todo)),
  deleteTodo: (todo) => dispatch(deleteTodo(todo)),
});

export default connect(mapStateToProps, mapDispatchToProps)(TodoList);
