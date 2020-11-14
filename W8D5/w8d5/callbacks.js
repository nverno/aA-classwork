#!/usr/bin/env node

// class Clock {
//   constructor() {
//     // 1. Create a Date object.
//     // 2. Store the hours, minutes, and seconds.
//     // 3. Call printTime.
//     // 4. Schedule the tick at 1 second intervals.
//     let date = new Date();
//     this.hours = date.getHours();
//     this.minutes = date.getMinutes();
//     this.seconds = date.getSeconds();
//     this.interval = setInterval(this._tick.bind(this), 1000);
//   }

//   printTime() {
//     // Format the time in HH:MM:SS
//     // Use console.log to print it.
//     console.log(`${this.hours}:${this.minutes}:${this.seconds}`)
//   }

//   _tick() {
//     // 1. Increment the time by one second.
//     // 2. Call printTime.
//     this.seconds += 1;
//     this.printTime()
//   }
// }

// const clock = new Clock();

// const readline = require('readline');
// const { CLIENT_RENEG_LIMIT } = require('tls');

// const reader = readline.createInterface({
//     input: process.stdin,
//     output: process.stdout
// });

// function addNumbers(sum, numsLeft, completionCallback) {
//     if (!numsLeft) {
//         completionCallback(sum);
//         reader.close();
//     } else {
//         reader.question("Give me a number: ", num => {
//             num = parseInt(num);
//             sum += num
//             numsLeft--;
//             console.log(sum);
//             addNumbers(sum, numsLeft, completionCallback);
//         });
//     }
// }

// const cb = num => console.log(`number is ${num}`);
// addNumbers(0, 3, cb);

// const readline = require('readline');

// const reader = readline.createInterface({
//   input: process.stdin,
//   output: process.stdout,
// });

// // Write this first.
// function askIfGreaterThan(el1, el2, callback) {
//   // Prompt user to tell us whether el1 > el2; pass true back to the
//   // callback if true; else false.
//   reader.question(`Is ${el1} > ${el2}? y/n`, (res) => {
//     callback(res === 'y');
//   });
// }

// // Once you're done testing askIfGreaterThan with dummy arguments, write this.
// function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop) {
//   if (i === arr.length - 1) outerBubbleSortLoop(madeAnySwaps);
//   else {
//     askIfGreaterThan(arr[i], arr[i + 1], (bool) => {
//       if (bool) {
//         [arr[i + 1], arr[i]] = [arr[i], arr[i + 1]];
//         innerBubbleSortLoop(arr, i + 1, true, outerBubbleSortLoop);
//       } else {
//         innerBubbleSortLoop(arr, i + 1, false, outerBubbleSortLoop);
//       }
//     });
//   }

//   // Do an "async loop":
//   // 1. If (i == arr.length - 1), call outerBubbleSortLoop, letting it
//   //    know whether any swap was made.
//   // 2. Else, use `askIfGreaterThan` to compare `arr[i]` and `arr[i +
//   //    1]`. Swap if necessary. Call `innerBubbleSortLoop` again to
//   //    continue the inner loop. You'll want to increment i for the
//   //    next call, and possibly switch madeAnySwaps if you did swap.
// }

// // Once you're done testing innerBubbleSortLoop, write outerBubbleSortLoop.
// // Once you're done testing outerBubbleSortLoop, write absurdBubbleSort.

// function absurdBubbleSort(arr, sortCompletionCallback) {
//   function outerBubbleSortLoop(madeAnySwaps) {
//     // Begin an inner loop if you made any swaps. Otherwise, call
//     // `sortCompletionCallback`.
//     if (madeAnySwaps) innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
//     else sortCompletionCallback(arr);
//   }
//   outerBubbleSortLoop(true)
//   // Kick the first outer loop off, starting `madeAnySwaps` as true.
// }

// absurdBubbleSort([3, 2, 1], function (arr) {
//   console.log('Sorted array: ' + JSON.stringify(arr));
//   reader.close();
// });

// const func = () => {
//   console.log(this)
// }
// Function.prototype.test = function() { }
// func.bind(will)

// Function.prototype.myBind = function(object) {
//     return (...rest) => {
//       this.apply(object, rest)
//     };
// }

// class Lamp {
//   constructor() {
//     this.name = "a lamp";
//   }
// }

// const turnOn = function(opt) {
//   console.log("Turning on " + this.name + (opt && opt || ""));
// };

// const lamp = new Lamp();

// turnOn(); // should not work the way we want it to

// const boundTurnOn = turnOn.bind(lamp);
// const myBoundTurnOn = turnOn.myBind(lamp);

// boundTurnOn(); // should say "Turning on a lamp"
// myBoundTurnOn(" now"); // should say "Turning on a lamp"


Function.prototype.myThrottle = function(timeInterval) {
  let tooSoon = false;
  return () => {
    if (tooSoon) {
      return console.log('too soon!');
    } else {
      setTimeout(() => {
        tooSoon = false;
      }, timeInterval);
      tooSoon = true;
      console.log('ran');
      console.log(this);
      return this();
    }
  };
};

// const fn = () => console.log("test");
// const throttled = fn.myThrottle(10000);
// throttled();
// throttled();
// throttled();
// throttled();

Function.prototype.myDebounce = function(timeInterval) {
  let startTimeout = () => setTimeout(() => {
    return this();
  }, timeInterval);
  let currTimeout = startTimeout();
  return () => {
    clearTimeout(currTimeout);
    currTimeout = startTimeout();
  };
};

// Test out myDebounce
class SearchBar {
  constructor() {
    this.query = "";

    this.type = this.type.bind(this);
    this.search = this.search.bind(this).myDebounce(500);
  }

  type(letter) {
    this.query += letter;
    this.search();
  }

  search() {
    console.log(`searching for ${this.query}`);
  }
}

const searchBar = new SearchBar();

const queryForHelloWorld = () => {
  searchBar.type("h");
  searchBar.type("e");
  searchBar.type("l");
  searchBar.type("l");
  searchBar.type("o");
  setTimeout(() => {
    searchBar.type(" ");
    searchBar.type("w");
    searchBar.type("o");
    searchBar.type("r");
    searchBar.type("l");
    searchBar.type("d");
  }, 1000);
};

queryForHelloWorld();
