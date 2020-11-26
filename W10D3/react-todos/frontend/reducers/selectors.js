export const allTodos = ({ todos }) =>
  Object.keys(todos).map((id) => todos[id]);

export const stepsByTodoId = ({ steps }, todoId) => {
  let res = [];
  for (const [_, val] of Object.entries(steps)) {
    if (val.todo_id === todoId) res.push(val);
  }
  return res;
};

export const allSteps = ({ steps }) => {
  let res = [];
  for (const [_, val] of Object.entries(steps)) {
    res.push(val);
  }
  return res;
};
