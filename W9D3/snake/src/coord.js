export default class Coord {
  constructor(x, y) {
    this.x = x;
    this.y = y;
    this.id = `cell-${this.x}-${this.y}`;
  }

  plus(dir) {
    switch (dir) {
      case "N":
        return new Coord(this.x - 1, this.y);
      case "E":
        return new Coord(this.x, this.y - 1);
      case "S":
        return new Coord(this.x + 1, this.y);
      case "W":
        return new Coord(this.x, this.y + 1);
    }
    throw "Bad!";
  }

  equals() {

  }
  
  isOpposite() {

  }
}
