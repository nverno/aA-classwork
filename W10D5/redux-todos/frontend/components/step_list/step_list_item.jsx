import React from 'react';

class StepListItem extends React.Component {
  constructor(props) {
    super(props);
    this.toggleStep = this.toggleStep.bind(this);
  }

  toggleStep(e) {
    const toggledStep = Object.assign({}, this.props.step, {
      done: !this.props.step.done,
    });
    this.props.updateStep(toggledStep);
  }

  render() {
    const {
      step: { title, body, done },
      deleteStep,
    } = this.props;
    return (
      <li className="step-header">
        <div className="step-info">
          <h3>{title}</h3>
          <p>{body}</p>
        </div>
        <div className="step-buttons">
          <button
            className={done ? 'done' : 'undone'}
            onClick={this.toggleStep}
          >
            {done ? 'Undo' : 'Done'}
          </button>
          <button className="delete-button" onClick={deleteStep}>
            Delete
          </button>
        </div>
      </li>
    );
  }
}

export default StepListItem;
