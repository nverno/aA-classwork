/*
 * ATTENTION: The "eval" devtool has been used (maybe by default in mode: "development").
 * This devtool is not neither made for production nor for readable output files.
 * It uses "eval()" calls to create a separate source file in the browser devtools.
 * If you are trying to read the output file, select a different devtool (https://webpack.js.org/configuration/devtool/)
 * or disable the default devtool with "devtool: false".
 * If you are looking for production-ready output files, see mode: "production" (https://webpack.js.org/configuration/mode/).
 */
/******/ (() => { // webpackBootstrap
/******/ 	"use strict";
/******/ 	var __webpack_modules__ = ({

/***/ "./src/board.js":
/*!**********************!*\
  !*** ./src/board.js ***!
  \**********************/
/*! namespace exports */
/*! export default [provided] [no usage info] [missing usage info prevents renaming] */
/*! other exports [not provided] [no usage info] */
/*! runtime requirements: __webpack_require__, __webpack_require__.r, __webpack_exports__, __webpack_require__.d, __webpack_require__.* */
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export */ __webpack_require__.d(__webpack_exports__, {\n/* harmony export */   \"default\": () => /* binding */ Board\n/* harmony export */ });\n/* harmony import */ var _coord_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./coord.js */ \"./src/coord.js\");\n/* harmony import */ var _snake_js__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./snake.js */ \"./src/snake.js\");\n\n\n\nconst CONSTANTS = {\n  MAX_APPLES: 10,\n  PROB_APPLE_SPAWN: 0.10,\n  DEFAULT_DIM: 40,\n};\n\nclass Board {\n  constructor(dim = CONSTANTS.DEFAULT_DIM) {\n    this.dim = dim;\n    this.snake = new _snake_js__WEBPACK_IMPORTED_MODULE_1__.default();\n    this.grid = this.setupBoard();\n    this.apples = 0;\n  }\n\n  step() {\n    this.apples -= this.snake.move();\n    this.snake.draw();\n    if (this.apples === 0 ||\n        this.apples < CONSTANTS.MAX_APPLES &&\n        Math.random() < CONSTANTS.PROB_APPLE_SPAWN)\n      this.generateApple();\n  }\n\n  generateApple() {\n    let coord = this.randomCell(),\n        $cell = $(`#${coord.id}`);\n\n    if ($cell.attr('class') !== 'snake') {\n      $cell.attr('class', 'apple');\n      this.apples++;\n    }\n  }\n\n  randomCell() {\n    return new _coord_js__WEBPACK_IMPORTED_MODULE_0__.default(\n      Math.floor(Math.random() * this.dim),\n      Math.floor(Math.random() * this.dim)\n    );\n  }\n\n  setupBoard() {\n    const grid = []; // [[row1], [row2]]\n    for (let i = 0; i < this.dim; i++) {\n      const row = [];\n      for (let j = 0; j < this.dim; j++) {\n        row.push(new _coord_js__WEBPACK_IMPORTED_MODULE_0__.default(i, j));\n      }\n      grid.push(row);\n    }\n    return grid;\n  }\n\n  draw($ul) {\n    for (let row of this.grid) {\n      for (let ele of row) {\n        $ul.append(`<li class=\"cell\" id=\"${ele.id}\"></li>`);\n      }\n    }\n    this.snake.draw();\n  }\n\n  reset($ul) {\n    this.clear($ul);\n    this.snake = new _snake_js__WEBPACK_IMPORTED_MODULE_1__.default();\n    this.apples = 0;\n  }\n\n  clear($ul) {\n    for (let row of this.grid) {\n      for (let ele of row) {\n        $(`#${ele.id}`).attr('class', '');\n      }\n    }\n  }\n}\n\n\n//# sourceURL=webpack://snake/./src/board.js?");

/***/ }),

/***/ "./src/coord.js":
/*!**********************!*\
  !*** ./src/coord.js ***!
  \**********************/
/*! namespace exports */
/*! export default [provided] [no usage info] [missing usage info prevents renaming] */
/*! other exports [not provided] [no usage info] */
/*! runtime requirements: __webpack_require__.r, __webpack_exports__, __webpack_require__.d, __webpack_require__.* */
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export */ __webpack_require__.d(__webpack_exports__, {\n/* harmony export */   \"default\": () => /* binding */ Coord\n/* harmony export */ });\nclass Coord {\n  constructor(x, y) {\n    this.x = x;\n    this.y = y;\n    this.id = `cell-${this.x}-${this.y}`;\n  }\n\n  plus(dir) {\n    switch (dir) {\n      case \"N\":\n        return new Coord(this.x - 1, this.y);\n      case \"E\":\n        return new Coord(this.x, this.y - 1);\n      case \"S\":\n        return new Coord(this.x + 1, this.y);\n      case \"W\":\n        return new Coord(this.x, this.y + 1);\n    }\n    throw \"Bad!\";\n  }\n\n  equals() {\n\n  }\n  \n  isOpposite() {\n\n  }\n}\n\n\n//# sourceURL=webpack://snake/./src/coord.js?");

/***/ }),

/***/ "./src/index.js":
/*!**********************!*\
  !*** ./src/index.js ***!
  \**********************/
/*! namespace exports */
/*! exports [not provided] [no usage info] */
/*! runtime requirements: __webpack_require__, __webpack_require__.r, __webpack_exports__, __webpack_require__.* */
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _board_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./board.js */ \"./src/board.js\");\n/* harmony import */ var _snake_js__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./snake.js */ \"./src/snake.js\");\n/* harmony import */ var _snake_view_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./snake_view.js */ \"./src/snake_view.js\");\n/* harmony import */ var _coord_js__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./coord.js */ \"./src/coord.js\");\n\n\n\n\n\n$(() => {\n  const $figure = $('.snake-grid');\n  const board = new _board_js__WEBPACK_IMPORTED_MODULE_0__.default(40);\n  const view = new _snake_view_js__WEBPACK_IMPORTED_MODULE_2__.default(board, $figure);\n\n  window.board = board;\n  window.view = board;\n});\n\n\n//# sourceURL=webpack://snake/./src/index.js?");

/***/ }),

/***/ "./src/snake.js":
/*!**********************!*\
  !*** ./src/snake.js ***!
  \**********************/
/*! namespace exports */
/*! export default [provided] [no usage info] [missing usage info prevents renaming] */
/*! other exports [not provided] [no usage info] */
/*! runtime requirements: __webpack_require__, __webpack_require__.r, __webpack_exports__, __webpack_require__.d, __webpack_require__.* */
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export */ __webpack_require__.d(__webpack_exports__, {\n/* harmony export */   \"default\": () => /* binding */ Snake\n/* harmony export */ });\n/* harmony import */ var _coord_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./coord.js */ \"./src/coord.js\");\n\n\nclass Snake {\n  constructor() {\n    this.segments = [new _coord_js__WEBPACK_IMPORTED_MODULE_0__.default(20, 20)];\n    this.dir = 'E';\n    this.DIRS = ['N', 'E', 'S', 'W'];\n    this.growTimes = 0;\n  }\n\n  move() {\n    let nextCell = this.segments[0].plus(this.dir),\n        $cell = $(`#${nextCell.id}`),\n        result = 0;\n\n    if ($cell.length === 0) {\n      console.log(\"Snake off grid\");\n      throw \"Game Over\";\n    }\n\n    if ($cell.attr('class') === 'snake') {\n      console.log(\"Hit yourself\");\n      throw 'Game Over';\n    }\n\n    if ($cell.attr('class') === 'apple') {\n      this.growTimes += 3;\n      console.log(\"Att an apple\");\n      result = 1;\n    }\n\n    this.grow();\n    if (this.growTimes === 0) {\n      let seg = this.segments.pop();\n      $(`#${seg.id}`).attr('class', '');\n    } else\n      this.growTimes--;\n\n    return result;\n  }\n\n  turn(dir) {\n    this.dir = dir;\n  }\n\n  grow() {\n    this.segments.unshift(this.segments[0].plus(this.dir));\n  }\n\n  draw() {\n    for (let seg of this.segments) {\n      $(`#${seg.id}`).attr('class', 'snake');\n    }\n  }\n}\n\n\n//# sourceURL=webpack://snake/./src/snake.js?");

/***/ }),

/***/ "./src/snake_view.js":
/*!***************************!*\
  !*** ./src/snake_view.js ***!
  \***************************/
/*! namespace exports */
/*! export default [provided] [no usage info] [missing usage info prevents renaming] */
/*! other exports [not provided] [no usage info] */
/*! runtime requirements: __webpack_require__.r, __webpack_exports__, __webpack_require__.d, __webpack_require__.* */
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export */ __webpack_require__.d(__webpack_exports__, {\n/* harmony export */   \"default\": () => /* binding */ View\n/* harmony export */ });\nclass View {\n  constructor(board, $el) {\n    this.$el = $el;\n    this.board = board;\n    this.elements = this.board.setupBoard();\n    this.buildBoard();\n    this.$grid = $(\"#grid-list\");\n    this.bindEvents();\n    this.running = false;\n  }\n\n  bindEvents() {\n    const that = this;\n    $(document).on('keydown', (event) => this.handleKeyEvent.bind(that)(event));\n  }\n\n  start() {\n    this.running = true;\n    window.gameInterval = window.setInterval(this.step.bind(this), 100);\n  }\n\n  pause() {\n    this.running = false;\n    clearInterval(window.gameInterval);\n    // window.gameInterval = window.setInterval(this.step, 100);\n  }\n\n  handleKeyEvent(event) {\n    // event.preventDefault();\n    switch (event.keyCode) {\n    case 40:\n      this.board.snake.turn('S');\n      break;\n    case 39:\n      this.board.snake.turn('W');\n      break;\n    case 37:\n      this.board.snake.turn('E');\n      break;\n    case 38:\n      this.board.snake.turn('N');\n      break;\n    case 32:\n      if (!this.running)\n        this.start();\n      else\n        this.pause();\n      break;\n    default:\n      break;\n    }\n    console.log(`Handled ${event.keyCode}`);\n  }\n\n  buildBoard() {\n    const $ul = $(\"<ul></ul>\");\n    this.$el.append($ul);\n    $ul.attr(\"id\", \"grid-list\");\n    this.board.draw($ul);\n  }\n\n  step() {\n    try {\n      this.board.step();\n    } catch (err) {\n      window.clearInterval(window.gameInterval);\n      alert(err + ' [SPC to restart]');\n      this.running = false;\n      this.board.reset(this.$grid);\n    }\n  }\n}\n\n\n//# sourceURL=webpack://snake/./src/snake_view.js?");

/***/ })

/******/ 	});
/************************************************************************/
/******/ 	// The module cache
/******/ 	var __webpack_module_cache__ = {};
/******/ 	
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/ 		// Check if module is in cache
/******/ 		if(__webpack_module_cache__[moduleId]) {
/******/ 			return __webpack_module_cache__[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = __webpack_module_cache__[moduleId] = {
/******/ 			// no module.id needed
/******/ 			// no module.loaded needed
/******/ 			exports: {}
/******/ 		};
/******/ 	
/******/ 		// Execute the module function
/******/ 		__webpack_modules__[moduleId](module, module.exports, __webpack_require__);
/******/ 	
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/ 	
/************************************************************************/
/******/ 	/* webpack/runtime/define property getters */
/******/ 	(() => {
/******/ 		// define getter functions for harmony exports
/******/ 		__webpack_require__.d = (exports, definition) => {
/******/ 			for(var key in definition) {
/******/ 				if(__webpack_require__.o(definition, key) && !__webpack_require__.o(exports, key)) {
/******/ 					Object.defineProperty(exports, key, { enumerable: true, get: definition[key] });
/******/ 				}
/******/ 			}
/******/ 		};
/******/ 	})();
/******/ 	
/******/ 	/* webpack/runtime/hasOwnProperty shorthand */
/******/ 	(() => {
/******/ 		__webpack_require__.o = (obj, prop) => Object.prototype.hasOwnProperty.call(obj, prop)
/******/ 	})();
/******/ 	
/******/ 	/* webpack/runtime/make namespace object */
/******/ 	(() => {
/******/ 		// define __esModule on exports
/******/ 		__webpack_require__.r = (exports) => {
/******/ 			if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 				Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 			}
/******/ 			Object.defineProperty(exports, '__esModule', { value: true });
/******/ 		};
/******/ 	})();
/******/ 	
/************************************************************************/
/******/ 	// startup
/******/ 	// Load entry module
/******/ 	__webpack_require__("./src/index.js");
/******/ 	// This entry module used 'exports' so it can't be inlined
/******/ })()
;