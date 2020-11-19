import Board from './board.js';
import View from './snake_view.js';
// import Snake from './snake.js';
// import Coord from './coord.js';

$(() => {
  const $figure = $('.snake-grid');
  const board = new Board(40);
  const view = new View(board, $figure);

  window.board = board;
  window.view = board;

  alert("SPC to start/pause/restart after death");
});
