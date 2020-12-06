import { connect } from 'react-redux';
import StepList from './step_list';
// Actions
import { stepsByTodoId } from '../../reducers/selectors';
import {
  fetchSteps,
  createStep,
  updateStep,
  deleteStep,
} from '../../actions/step_actions';

const mapStateToProps = (state, { todo_id }) => ({
  steps: stepsByTodoId(state, todo_id),
  todo_id,
});

const mapDispatchToProps = (dispatch) => ({
  fetchSteps: (todo_id) => dispatch(fetchSteps(todo_id)),
  createStep: (todo_id, step) => dispatch(createStep(todo_id, step)),
  updateStep: (todo_id, step) => dispatch(updateStep(todo_id, step)),
  deleteStep: (step) => dispatch(deleteStep(step)),
});

export default connect(mapStateToProps, mapDispatchToProps)(StepList);
