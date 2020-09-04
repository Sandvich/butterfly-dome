import "input" for Mouse
import "graphics" for Canvas, Color, Point
import "./globalRandom" for Generator

class Racer {
    construct new(x, y) {
        _loc = Point.new(x,y)
        _velocity = Point.new(0,0)
        _maxAccel = 5
        _maxVelocity = 30
        _g = Point.new(0, 2)
        _generator = Generator
    }

    move(towardsVector) {
        _accel = (towardsVector - _loc) / 20
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

	loc { _loc }
}
