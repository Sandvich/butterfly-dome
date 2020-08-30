import "input" for Mouse
import "graphics" for Canvas, Color, Point

class Player {
    construct new(parent) {
        _loc = Point.new(400,300)
        _parent = parent
    }

    mouseHandler() {}
    update() {
        _parent.addTempCanvasItem(this, x, y)
    }

    draw(x, y) {
        System.print("Called draw() on Player")
        Canvas.circlefill(x, y, 5, Color.white)
    }

	x { _loc.x }
	y { _loc.y }
}