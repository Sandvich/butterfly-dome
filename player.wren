import "input" for Mouse
import "graphics" for Canvas, Color, Point
import "./racer" for Racer

class Player is Racer {
    construct new(parent) {
        super(300, 400, Racer.Green)
        _parent = parent
    }

    update() {
        super()
        move(Point.new(Mouse.x, Mouse.y))
        _parent.addTempCanvasItem(this, x, y)
    }
}
