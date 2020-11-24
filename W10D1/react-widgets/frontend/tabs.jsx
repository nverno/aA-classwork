import React from 'react';

// <Tabs list={list} />
export default class Tabs extends React.Component {
  constructor(props) {
    super(props);
    this.state = { idx: 0 };
  }

  selectTab(i) {
    this.setState({
      idx: i,
    });
  }

  render() {
    // const tabs = props
    return (
      <>
        <h1>Tabs</h1>
        <div className="tabs">
          <ul>
            {this.props.tabs.map((tab, idx) => (
              <li>
                <span
                  key={tab.objectID}
                  onClick={this.selectTab.bind(this, idx)}
                >
                  {tab.title}
                </span>
              </li>
            ))}
          </ul>
          <article>{this.props.tabs[this.state.idx].content}</article>
        </div>
      </>
    );
  }
}
