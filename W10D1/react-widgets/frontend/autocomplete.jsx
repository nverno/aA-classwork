import React, { Component } from 'react';

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

  render() {
    const items = this.filteredItems();

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
            {items.map((item) => (
              <li key={item.objectID}>{item}</li>
            ))}
          </ul>
        </div>
      </>
    );
  }
}
