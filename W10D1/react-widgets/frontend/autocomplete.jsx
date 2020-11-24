import React, { Component } from 'react';
import { CSSTransition, TransitionGroup } from 'react-transition-group';

export default class Autocomplete extends Component {
  constructor(props) {
    super(props);
    this.state = {
      inputVal: '',
    };
  }

  filteredItems() {
    return this.props.list.filter((item) =>
      item.toLowerCase().includes(this.state.inputVal.toLowerCase())
    );
  }

  handleSearch(e) {
    this.setState({ inputVal: e.target.value });
  }

  handleClick(e) {
    this.setState({ inputVal: e.currentTarget.innerText });
  }

  render() {
    const items = this.filteredItems().map((item, idx) => (
      <CSSTransition
        key={idx}
        classNames="auto"
        timeout={{ enter: 500, exit: 500 }}
      >
        <li key={idx} onClick={this.handleClick.bind(this)}>
          {item}
        </li>
      </CSSTransition>
    ));

    return (
      <>
        <h1>Autocomplete</h1>
        <div className="autocomplete">
          <label htmlFor="search">Search: </label>
          <input
            id="search"
            type="text"
            value={this.state.inputVal}
            onChange={this.handleSearch.bind(this)}
          />
          <ul>
            <TransitionGroup>{items}</TransitionGroup>
          </ul>
        </div>
      </>
    );
  }
}
