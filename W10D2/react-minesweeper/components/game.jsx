import React from 'react';
import Board from './board';
import * as Minesweeper from './minesweeper.js';

const bombs = () => 1; //10 + Math.floor(Math.random() * 15);

export default class Game extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      board: new Minesweeper.Board(9, bombs()),
    };
    this.updateGame = this.updateGame.bind(this);
    this.restartGame = this.restartGame.bind(this);
  }

  updateGame(tile, flagged) {
    if (flagged) {
      tile.toggleFlag();
    } else {
      tile.explore();
    }

    this.setState({ board: this.state.board });
  }

  restartGame() {
    this.setState({ board: new Minesweeper.Board(9, bombs()) });
  }

  render() {
    let modal;

    if (this.state.board.lost() || this.state.board.won()) {
      let text = this.state.board.lost()
        ? (this.state.board.showAll(), 'You lost!')
        : 'You won!';
      modal = (
        <div className="modal-screen">
          <div className="modal-content">
            {text} <br /> <br />
            <button onClick={this.restartGame}>Play Again!</button>
          </div>
        </div>
      );
    }

    return (
      <>
        <h1> Our Minesweeper</h1>
        <Board board={this.state.board} updateGame={this.updateGame} />
        {modal}
      </>
    );
  }
}
