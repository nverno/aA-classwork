import React from 'react';

const StepListItem = ({ step, receiveStep, removeStep }) => {
  const { title, body } = step;

  const toggleDone = () => {
    receiveStep(Object.assign({}, step, { done: !step.done }));
  };

  const buttonText = step.done ? 'Undo' : 'Done';
  return (
    <li className="step-list-item">
      <div className="step-list-title">
        <h3>{title}</h3>
      </div>
      <p>{body}</p>

      <div className="step-list-buttons">
        <button onClick={() => removeStep(step)}>Delete</button>
        &nbsp;
        <button onClick={toggleDone}>{buttonText}</button>
      </div>
    </li>
  );
};

export default StepListItem;
