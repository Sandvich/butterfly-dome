import "input" for Mouse
import "graphics" for Canvas, Color, Point
import "./racer" for Racer

class Player is Racer {
    construct new(parent) {
        super(300, 400)
        _parent = parent
    }

    mouseHandler() {
        move(Point.new(Mouse.x, Mouse.y))
    }

    update() {
        _parent.addTempCanvasItem(this, x, y)
    }

    draw(x, y) {
        Canvas.circlefill(x, y, 5, Color.white)
    }

	x { loc.x }
	y { loc.y }
}
