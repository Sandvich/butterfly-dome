import "input" for Mouse
import "graphics" for Canvas, Color, Point

class Player {
    construct new(parent) {
        _parent = parent
        _loc = Point.new(400,300)
        _toMove = Point.new(0,0)
        _speed = 5
    }

    mouseHandler() {
        _toMove = (Point.new(Mouse.x, Mouse.y) - _loc) / 20
        if (_toMove.length > _speed) {
            _toMove = _toMove.unit * _speed
        }
        _loc = _loc + _toMove
    }

    update() {
        _parent.addTempCanvasItem(this, x, y)
    }

    draw(x, y) {
        Canvas.circlefill(x, y, 5, Color.white)
    }

	x { _loc.x }
	y { _loc.y }
}