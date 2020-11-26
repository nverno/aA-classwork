import React from 'react';
import StepListItemContainer from './step_list_item_container';
import StepForm from './step_form';

const StepList = ({ steps, todo_id, receiveStep }) => {
  return (
    <>
      <ul className="step-list">
        {steps.map((step, idx) => (
          <StepListItemContainer key={idx} step={step} />
        ))}
        <StepForm todo_id={todo_id} receiveStep={receiveStep} />
      </ul>
    </>
  );
};

export default StepList;
