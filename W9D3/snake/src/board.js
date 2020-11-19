import Coord from './coord.js';
import Snake from './snake.js';

const CONSTANTS = {
  MAX_APPLES: 10,
  PROB_APPLE_SPAWN: 0.10,
  DEFAULT_DIM: 40,
};

export default class Board {
  constructor(dim = CONSTANTS.DEFAULT_DIM) {
    this.dim = dim;
    this.snake = new Snake();
    this.grid = this.setupBoard();
    this.apples = 0;
  }

  step() {
    this.apples -= this.snake.move();
    this.snake.draw();
    if (this.apples === 0 ||
        this.apples < CONSTANTS.MAX_APPLES &&
        Math.random() < CONSTANTS.PROB_APPLE_SPAWN)
      this.generateApple();
  }

  generateApple() {
    let coord = this.randomCell(),
        $cell = $(`#${coord.id}`);

    if ($cell.attr('class') !== 'snake') {
      $cell.attr('class', 'apple');
      this.apples++;
    }
  }

  randomCell() {
    return new Coord(
      Math.floor(Math.random() * this.dim),
      Math.floor(Math.random() * this.dim)
    );
  }

  setupBoard() {
    const grid = []; // [[row1], [row2]]
    for (let i = 0; i < this.dim; i++) {
      const row = [];
      for (let j = 0; j < this.dim; j++) {
        row.push(new Coord(i, j));
      }
      grid.push(row);
    }
    return grid;
  }

  draw($ul) {
    for (let row of this.grid) {
      for (let ele of row) {
        $ul.append(`<li class="cell" id="${ele.id}"></li>`);
      }
    }
    this.snake.draw();
  }

  reset($ul) {
    this.clear($ul);
    this.snake = new Snake();
    this.apples = 0;
  }

  clear($ul) {
    for (let row of this.grid) {
      for (let ele of row) {
        $(`#${ele.id}`).attr('class', '');
      }
    }
  }
}
