import Coord from './coord.js';

const CONSTANTS = {
  START_X: 20,
  START_Y: 20,
  START_DIR: 'E',
  DIRS: ['N', 'E', 'S', 'W'],
  GROW_LENGTH: 3,
};

export default class Snake {
  constructor() {
    this.segments = [new Coord(CONSTANTS.START_X, CONSTANTS.START_Y)];
    this.dir = CONSTANTS.START_DIR;
    this.growTimes = 0;
  }

  move() {
    let nextCell = this.segments[0].plus(this.dir),
        $cell = $(`#${nextCell.id}`),
        result = 0;

    if ($cell.length === 0) {
      console.log("Snake off grid");
      throw "Game Over";
    }

    if ($cell.attr('class') === 'snake') {
      console.log("Hit yourself");
      throw 'Game Over';
    }

    if ($cell.attr('class') === 'apple') {
      this.growTimes += CONSTANTS.GROW_LENGTH;
      console.log("Att an apple");
      result = 1;
    }

    this.grow();
    if (this.growTimes === 0) {
      let seg = this.segments.pop();
      $(`#${seg.id}`).attr('class', '');
    } else
      this.growTimes--;

    return result;
  }

  turn(dir) {
    this.dir = dir;
  }

  grow() {
    this.segments.unshift(this.segments[0].plus(this.dir));
  }

  draw() {
    for (let seg of this.segments) {
      $(`#${seg.id}`).attr('class', 'snake');
    }
  }
}
