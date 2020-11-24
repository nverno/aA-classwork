import React from 'react';

export default class Clock extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      time: new Date().toLocaleString('en-US', {
        timeZone: 'America/Los_Angeles',
      }),
    };
  }

  tick() {
    this.setState({
      time: new Date().toLocaleString('en-US', {
        timeZone: 'America/Los_Angeles',
      }),
    });
  }

  componentDidMount() {
    this.handle = setInterval(this.tick.bind(this), 1000);
  }

  componentWillUnmount() {
    clearInterval(this.handle);
  }

  render() {
    return (
      <>
        <h1>Clock</h1>
        <div className="clock">{this.state.time}</div>
      </>
    );
  }
}
