export default class View {
  constructor(board, $el) {
    this.$el = $el;
    this.board = board;
    this.elements = this.board.setupBoard();
    this.buildBoard();
    this.$grid = $("#grid-list");
    this.bindEvents();
    this.running = false;
  }

  bindEvents() {
    const that = this;
    $(document).on('keydown', (event) => this.handleKeyEvent.bind(that)(event));
  }

  start() {
    this.running = true;
    window.gameInterval = window.setInterval(this.step.bind(this), 100);
  }

  pause() {
    this.running = false;
    clearInterval(window.gameInterval);
    // window.gameInterval = window.setInterval(this.step, 100);
  }

  handleKeyEvent(event) {
    // event.preventDefault();
    switch (event.keyCode) {
    case 40:
      this.board.snake.turn('S');
      break;
    case 39:
      this.board.snake.turn('W');
      break;
    case 37:
      this.board.snake.turn('E');
      break;
    case 38:
      this.board.snake.turn('N');
      break;
    case 32:
      if (!this.running)
        this.start();
      else
        this.pause();
      break;
    default:
      break;
    }
    console.log(`Handled ${event.keyCode}`);
  }

  buildBoard() {
    const $ul = $("<ul></ul>");
    this.$el.append($ul);
    $ul.attr("id", "grid-list");
    this.board.draw($ul);
  }

  step() {
    try {
      this.board.step();
    } catch (err) {
      window.clearInterval(window.gameInterval);
      alert(err + ' [SPC to restart]');
      this.running = false;
      this.board.reset(this.$grid);
    }
  }
}
