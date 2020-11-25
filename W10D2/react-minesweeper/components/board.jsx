import React, { Component } from 'react';
import Tile from './tile';

export default class Board extends Component {
  // props = { updateGame, board }
  constructor(props) {
    super(props);
  }

  render() {
    const { updateGame, board } = this.props;

    const grid = board.grid.map((row, idx1) => {
      return (
        <div key={`row-${idx1}`} className={'row'}>
          {' '}
          {row.map((tile, idx2) => {
            return (
              <div key={`${idx1}-${idx2}`}>
                <Tile tile={tile} updateGame={updateGame} />
              </div>
            );
          })}
        </div>
      );
    });

    // console.log(grid);
    return (
      <>
        <p>
          {' '}
          Click to explore a tile. <br /> Alt + click to flag a tile.{' '}
        </p>
        {grid}
      </>
    );
  }
}
