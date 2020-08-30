import "input" for Mouse
import "graphics" for Canvas, Color, Point
import "random" for Random

class Player {
    construct new(parent) {
        _parent = parent
        _loc = Point.new(400,300)
        _velocity = Point.new(0,0)
        _maxAccel = 5
        _maxVelocity = 30
        _g = Point.new(0, 2)
        _generator = Random.new()
    }

    mouseHandler() {
        _accel = (Point.new(Mouse.x, Mouse.y) - _loc) / 20
        if (_accel.length > _maxAccel) {
            _accel = _accel.unit * _maxAccel
        }
        var erratic = Point.new(_generator.float(-1,1), _generator.float(-1,1)).unit * _generator.float() * _maxAccel
        _velocity = _velocity + _accel + _g + erratic
        if (_velocity.length > _maxVelocity) {
            _velocity = _velocity.unit * _maxVelocity
        }
        _loc = _loc + _velocity
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