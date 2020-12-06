import { connect } from 'react-redux';
import TodoDetailView from './todo_detail_view';
// Actions
import { removeTodo } from '../../actions/todo_actions';
import { fetchSteps } from '../../actions/step_actions';

const mapDispatchToProps = (dispatch, { todo }) => ({
  removeTodo: () => dispatch(removeTodo(todo)),
  fetchSteps: () => dispatch(fetchSteps(todo.id)),
});

export default connect(
  null, // todo props is already passed in
  mapDispatchToProps
)(TodoDetailView);
