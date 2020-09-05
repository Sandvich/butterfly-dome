import "input" for Mouse
import "graphics" for Canvas, Color, Point, ImageData
import "./globals" for Generator
import "./api" for Maths

class Racer {
    construct new(x, y, colour) {
        _loc = Point.new(x,y)
        _velocity = Point.new(0,0)
        _maxAccel = 3
        _maxVelocity = 15
        _g = Point.new(0, 2)
        _generator = Generator
        _image = ImageData.loadFromFile(colour)
        _frames = []
        _reverseFrames = []
        for (i in Maths.range(12)) {
            _frames.add(_image.transform({"srcX": i*30, "srcY": 0,"srcW": 30, "srcH": 25}))
            _reverseFrames.add(_image.transform({"srcX": i*30, "srcY": 0,"srcW": 30, "srcH": 25, "scaleX": -1}))
        }
        _currentFrameIndex = 0
        _count = 0
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

    update() {
        if (_count == 4) {
            _currentFrameIndex = _currentFrameIndex + 1
            if (_currentFrameIndex == 12) { _currentFrameIndex = 0}
            _count = 0
        } else {
            _count = _count + 1
        }
    }

    draw(x, y) {
        if ( _velocity.x >= 0 ) {
            _frames[_currentFrameIndex].draw(x-15, y-12)
        } else {
            _reverseFrames[_currentFrameIndex].draw(x-15, y-12)
        }
    }

	loc { _loc }
	x { _loc.x }
	y { _loc.y }

    static Blue { "img/butterfly-blue-sheet.png" }
    static Green { "img/butterfly-green-sheet.png" }
    static Orange { "img/butterfly-orange-sheet.png" }
    static White { "img/butterfly-white-sheet.png" }
    static Yellow { "img/butterfly-yellow-sheet.png" }
}
