import * as APIUtil from '../util/step_api_util';

export const RECEIVE_STEPS = 'RECEIVE_STEPS';
export const RECEIVE_STEP = 'RECEIVE_STEP';
export const REMOVE_STEP = 'REMOVE_STEP';

export const receiveSteps = (steps) => ({
  type: RECEIVE_STEPS,
  steps,
});

export const receiveStep = (step) => ({
  type: RECEIVE_STEP,
  step,
});

export const removeStep = (step) => ({
  type: REMOVE_STEP,
  step,
});

export const fetchSteps = (todo_id) => (dispatch) =>
  APIUtil.fetchSteps(todo_id).then((steps) => dispatch(receiveSteps(steps)));

export const createStep = (todo_id, step) => (dispatch) =>
  APIUtil.createStep(todo_id, step).then((step) => dispatch(receiveStep(step)));

export const updateStep = (step) => (dispatch) =>
  APIUtil.updateStep(step).then((step) => dispatch(receiveStep(step)));

export const deleteStep = (step) => (dispatch) =>
  APIUtil.deleteStep(step).then((step) => dispatch(removeStep(step)));
