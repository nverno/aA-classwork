import React, { Component } from 'react';

export default class Tile extends Component {
  // props: { tile, updateGame }
  constructor(props) {
    super(props);
    this.handleClick = this.handleClick.bind(this);
  }

  // ⚑, ☢
  handleClick(e) {
    let flagged = e.altKey ? true : false;
    this.props.updateGame(this.props.tile, flagged);
  }

  render() {
    const tile = this.props.tile;
    const numExplored = tile.explored ? tile.adjacentBombCount() || ' ' : '';
    const tileBombed =
      tile.explored && tile.bombed ? (
        <div className="bombed">☢</div>
      ) : (
        numExplored
      );
    return (
      <div
        className={tile.explored ? 'tile explored' : 'tile unexplored'}
        onClick={this.handleClick}
      >
        {(this.props.tile.flagged && <div className="flagged">⚑</div>) ||
          tileBombed ||
          numExplored}
      </div>
    );
  }
}
